<?php

namespace Drupal\migrate_source_directory\Plugin\migrate\source;

use Drupal\migrate\MigrateException;
use Drupal\migrate\Plugin\migrate\source\SourcePluginBase;
use Drupal\migrate\Plugin\MigrationInterface;
use Drupal\migrate\Row;

/**
 * Source for a given directory path.
 *
 * @MigrateSource(
 *   id = "directory",
 *   source_module = "migrate_source_directory",
 * )
 */
class Directory extends SourcePluginBase {

  /**
   * Recurse level of directory search.
   *
   * Uses http://php.net/manual/en/recursiveiteratoriterator.setmaxdepth.php.
   *
   * @var int
   */
  protected $recurseLevel = -1;

  /**
   * A list of files from the provided directory, and possible children.
   *
   * @var array
   */
  protected $filesList = [];

  /**
   * An list of directories to search.
   *
   * @var array
   */
  protected $directories = [];

  /**
   * Optional prefix prepended to the file path when creating an ID.
   *
   * This helps avoid a possible conflict where you're importing from two
   * different directories that each contain a file named "README.md". Defaults
   * to the ID of the migration if none is provided.
   *
   * @var string
   */
  protected $idPrefix;

  /**
   * Regular expresion; Only use files with names matching this expression.
   * @var string
   */
  protected $fileMask;

  /**
   * An array of strings that must be present in the file for it to be included.
   *
   * @var array
   */
  protected $fileMustContainString = [];

  /**
   * {@inheritdoc}
   */
  public function __construct(array $configuration, $plugin_id, $plugin_definition, MigrationInterface $migration) {
    parent::__construct($configuration, $plugin_id, $plugin_definition, $migration);

    $this->idPrefix = $this->configuration['id_prefix'] ?? '';
    $this->fileMask = $this->configuration['file_mask'] ?? FALSE;
    if (!empty($this->configuration['file_must_contain_string'])) {
      $this->fileMustContainString = is_array($this->configuration['file_must_contain_string']) ? $this->configuration['file_must_contain_string'] : [$this->configuration['file_must_contain_string']];
    }

    // We used to use 'urls', but changed the configuration key to 'directory'.
    // This allows backwards compatibility.
    if (empty($this->configuration['directory']) && !empty($this->configuration['urls'])) {
      $this->configuration['directory'] = $this->configuration['urls'];
    }

    // Path is required.
    if (empty($this->configuration['directory'])) {
      throw new MigrateException('The "directory" configuration option is required.');
    }

    if (!empty($this->configuration['directory'])) {
      $this->configuration['directory'] = is_array($this->configuration['directory']) ? $this->configuration['directory'] : [$this->configuration['directory']];
    }

    foreach ($this->configuration['directory'] as $directory) {
      if (!is_dir($directory)) {
        throw new MigrateException('The "directory" configuration ' . $directory .' is not a valid directory path');
      }
    }

    if (!empty($this->configuration['recurse_level']) && !is_numeric($this->configuration['recurse_level'])) {
      throw new MigrateException('You must declare the \'recurse_level\' as an integer');
    }
    else {
      $this->recurseLevel = $this->configuration['recurse_level'] ?? $this->recurseLevel;
    }
  }

  /**
   * Return a string representing the source file path.
   *
   * @return string
   *   The file path.
   */
  public function __toString() {
    return 'Importing files from ' . implode(', ', $this->directories);
  }

  /**
   * {@inheritdoc}
   */
  public function initializeIterator() {
    foreach ($this->configuration['directory'] as $directory) {
      // Return SPL file objects instead of just the string file path.
      $directory_iterator = new \RecursiveDirectoryIterator($directory, \RecursiveDirectoryIterator::KEY_AS_PATHNAME);
      $files = new \RecursiveIteratorIterator($directory_iterator);
      $files->setMaxDepth($this->recurseLevel);

      if ($this->fileMask) {
        $files = new \RegexIterator($files, $this->fileMask, \RegexIterator::MATCH, \RegexIterator::USE_KEY);
      }

      if (count($this->fileMustContainString)) {
        $filters = $this->fileMustContainString;
        $files = new \CallbackFilterIterator($files, function ($current, $key, $iterator) use ($filters) {
          $haystack = file_get_contents($current->getPathname());
          foreach ($filters as $needle) {
            if (strpos($haystack, $needle) === FALSE) {
              return FALSE;
            }
          }
          return TRUE;
        });
      }

      /** @var \SplFileObject $file */
      foreach ($files as $file) {
        array_push($this->filesList, [
          // Set the ID to the path to the file relative to $directory.
          'sourceID' => $this->idPrefix . substr($file->getPathname(), strlen($directory)),
          'source_file_basename' => $file->getBasename(),
          'source_file_extension' => $file->getExtension(),
          'source_file_filename' => $file->getFilename(),
          'source_file_mtime' => $file->getMTime(),
          'source_file_path' => $file->getPath(),
          'source_file_pathname' => $file->getPathname(),
          'source_file_realpath' => $file->getRealPath(),
          'source_file_size' => $file->getSize(),
          'source_file_type' => $file->getType(),
        ]);
      }
    }

    return new \ArrayIterator($this->filesList);
  }

  /**
   * {@inheritdoc}
   */
  public function getIds() {
    return ['sourceID' => ['type' => 'string']];
  }

  /**
   * {@inheritdoc}
   */
  public function fields() {
    return [
      'sourceID' => 'Unique ID of the file (filepath)',
      'source_file_basename' => 'Base name of the file',
      'source_file_extension' => 'File extension',
      'source_file_filename' => 'Filename and extension',
      'source_file_mtime' => 'Time the file was last updated',
      'source_file_path' => 'Path without filename',
      'source_file_pathname' => 'Path to the file',
      'source_file_realpath' => 'Absolute path to the file',
      'source_file_size' => 'File size',
      'source_file_type' => 'File type',
    ];
  }

}
