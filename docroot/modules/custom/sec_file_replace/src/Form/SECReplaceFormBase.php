<?php

/**
 * @file
 * Contains \Drupal\sec_file_replace\Form\SECReplaceFormBase.
 */

namespace Drupal\sec_file_replace\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Session\SessionManagerInterface;
use Drupal\user\PrivateTempStoreFactory;
use Symfony\Component\DependencyInjection\ContainerInterface;

abstract class SECReplaceFormBase extends FormBase
{

    /**
   * @var \Drupal\user\PrivateTempStoreFactory
   */
    protected $tempStoreFactory;

    /**
   * @var \Drupal\user\PrivateTempStore
   */
    protected $store;

    /**
   * Constructs a \Drupal\demo\Form\Multistep\MultistepFormBase.
   *
   * @param \Drupal\user\PrivateTempStoreFactory $temp_store_factory
   */
    public function __construct(PrivateTempStoreFactory $temp_store_factory) 
    {
        $this->tempStoreFactory = $temp_store_factory;
        $this->store = $this->tempStoreFactory->get('multistep_data');
    }

    /**
   * {@inheritdoc}
   */
    public static function create(ContainerInterface $container) 
    {
        return new static(
        $container->get('user.private_tempstore')
        );
    }

    /**
   * {@inheritdoc}.
   */
    public function buildForm(array $form, FormStateInterface $form_state) 
    {

        $form = [];
        $form['actions']['#type'] = 'actions';
        $form['actions']['submit'] = [
        '#type' => 'submit',
        '#value' => $this->t('Submit'),
        '#button_type' => 'primary',
        '#weight' => 10,
        ];

        return $form;
    }

    /**
   * Helper method that removes all the keys from the store collection used for
   * the multistep form.
   */
    protected function deleteStore() 
    {
        $keys = ['file_name', 'file_upload', 'node'];
        foreach ($keys as $key) {
            $this->store->delete($key);
        }
    }

}
