# Migrate Source Directory

Use a directory of files as the source for a migration.

Common use cases include:

- Import a set of files from a directory as Drupal file entities
- Find all Markdown files in a directory and create a content entity for each one

## Source plugin configuration options:

```yaml
source:
  constants:
    uri_file: 'public://' #required
  plugin: directory
  track_changes: true
  # One or more directories to scan for files. Will recurse into subdirectories.
  directory:
    - /path/to/files/for/import
  # (optional) A regex mask to apply to file paths, relative to the directory(s)
  # above. Only files that match this pattern will be processed. Use to do
  # things like only process files with a given extension.
  file_mask: '/(.*\.(mp3|m4a|wav)$)/i'
  # (optional) How deep to recurse into subdirectories. -1 (default) for no
  # limit.
  recurse_level: -1
  # (optional) prefix to add to the sourceID when processing files. The default
  # for sourceID is the path to the file relative to the directory set above.
  id_prefix: 'optional_sourceid_prefix'
  # (optional) List of one or more strings that a file must contain in order
  # to be considered for processing. This probably only really works with text
  # like files since it uses strpos().
  file_must_contain_string:
    - '<div class="chapter">'
```

This plugin provides the following source fields:

- `sourceID`: Unique ID of the file (filepath)
- `source_file_basename`: Base name of the file
- `source_file_extension`: File extension
- `source_file_filename`: Filename and extension
- `source_file_mtime`: Time the file was last updated
- `source_file_path`: Path without filename
- `source_file_pathname`: Path to the file
- `source_file_realpath`: Absolute path to the file
- `source_file_size`: File size
- `source_file_type`: File type

## Create Drupal File entities from a directory of files

Use the plugin like so to import files in to Drupal:

```yaml
id: directory_mp3
label: 'Import audio files'
source:
  plugin: directory
  constants:
    uri_file: 'public://'
  track_changes: true
  directory:
    - /path/to/files/for/import
    - /path/to/additional_files
  # (optional) A regex mask to apply to file paths, relative to the directory(s)
  # above. Only files that match this pattern will be processed. Use to do
  # things like only process files with a given extension.
  file_mask: '/(.*\.(mp3|m4a|wav)$)/i'
  # (optional) How deep to recurse into subdirectories. -1 (default) for no
  # limit.
  recurse_level: -1

process:
  source_full_path: path
  uri_file:
    -
      plugin: concat
      delimiter: /
      source:
        - constants/uri_file
        - filename
    -
      plugin: urlencode
  filename: filename
  uri:
    plugin: file_copy
    source:
      - '@source_full_path'
      - '@uri_file'

destination:
  plugin: 'entity:file'

migration_dependencies:
  required: {  }
  optional: {  }
```

To reference these files in other migrations, use the source property `sourceID`. This is the path to the file relative to `source.directory`.

## Create Drupal content entities from a directory of files

You can also use this to iterate over a set of files, and import the content of those files as Drupal content entities. For example; a directory of Markdown files could be imported as nodes with a migration like this:

```yaml
id: markdown_import
label: 'Import markdown files'

source:
  plugin: directory
  track_changes: true
  directory:
    - /path/to/files/for/import
  # All files with a .md extension, excluding README.md files.
  file_mask: '/^(.*\.md)(?<!README\.md)$/i'
  recurse_level: -1

process:
  type:
    plugin: default_value
    default_value: "basic_page"
  title: title
  body/value: body
  body/format:
    plugin: default_value
    default_value: "markdown"
  changed: last_updated

destination:
  plugin: 'entity:node'

migration_dependencies:
  required: {  }
  optional: {  }
```

And either a corresponding implementation of `hook_migrate_prepare_row()`, or a custom source plugin class that extends `\Drupal\migrate_source_directory\Plugin\migrate\source\Directory` and implements the required logic in its own `prepareRow()` method.

Example:

```php
function hook_migrate_prepare_row(Row $row, MigrateSourceInterface $source, MigrationInterface $migration) {
  if ($migration->id() == 'markdown_import') {
    $content = file_get_contents($row->getSourceProperty('source_file_realpath'));

    // The first line of the file, if it starts with `#` is the title.
    $title = strtok($content, "\n");
    if (substr($title, 0, 1) == '#') {
      $row->setSourceProperty('title', trim(substr($title, 1)));

      // Remove the first line (we're done with it), and any empty newlines
      // above/below the resulting content.
      $content = trim(substr($content, strpos($content, "\n") + 1));
    }

    // And the rest is the body.
    $row->setSourceProperty('body', $content);
  }
}
```
