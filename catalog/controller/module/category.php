<?php  
class ControllerModuleCategory extends Controller {
	protected function index($setting) {
		$this->language->load('module/category');
		
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_description'] = $this->language->get('text_no_description');
		
		$this->data['setting'] = $setting;
		
		$this->data['top_bottom'] = $setting['position'] == 'content_top' || $setting['position'] == 'content_bottom';
		$this->data['side_left'] = $setting['position'] == 'column_left';
		$this->data['side_right'] = $setting['position'] == 'column_right';
		$this->data['side'] = $setting['position'] == 'column_left' || $setting['position'] == 'column_right';

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if (isset($parts[0])) {
			$this->data['category_id'] = $parts[0];
		} else {
			$this->data['category_id'] = 0;
		}
		
		if (isset($parts[1])) {
			$this->data['child_id'] = $parts[1];
		} else {
			$this->data['child_id'] = 0;
		}
		
		if (isset($parts[2])) {
            $this->data['child2_id'] = $parts[2];
        } else {
            $this->data['child2_id'] = 0;
        }

        if (isset($parts[3])) {
            $this->data['child3_id'] = $parts[3];
        } else {
            $this->data['child3_id'] = 0;
        }
							
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');
		

		$this->data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);
		

		



		foreach ($categories as $category) {
			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);
			
			$trimmed_name = strip_tags(html_entity_decode($category['name'], ENT_QUOTES, 'UTF-8'));
			
			

			foreach ($children as $child) {
				$data = array(
					'filter_category_id'  => $child['category_id'],
					'filter_sub_category' => true
				);
				
				$children2_data = array();
				
                $children2 = $this->model_catalog_category->getCategories($child['category_id']);
				
				$child_trimmed_name = strip_tags(html_entity_decode($child['name'], ENT_QUOTES, 'UTF-8'));
			

				


                foreach ($children2 as $child2) {

                    $data2 = array(
                        'filter_category_id'  => $child2['category_id'],
                        'filter_sub_category' => true
                    );

                    $product_total2 = $this->model_catalog_product->getTotalProducts($data2);

                    $children3_data = array();
					
                    $children3 = $this->model_catalog_category->getCategories($child2['category_id']);
					
					$child2_trimmed_name = strip_tags(html_entity_decode($child2['name'], ENT_QUOTES, 'UTF-8'));

					
					
					if ($child['description']) {
						$child2_description = utf8_substr(strip_tags(html_entity_decode($child2['description'], ENT_QUOTES, 'UTF-8')), 0, $setting['description_limit']) . '...';
					} else {
						$child2_description = '';
					}

                    foreach ($children3 as $child3) {

                        $data3 = array(
                            'filter_category_id'  => $child3['category_id'],
                            'filter_sub_category' => true
                        );

                        $product_total3 = $this->model_catalog_product->getTotalProducts($data3);

                        $children3_data[] = array(
                            'category_id' => $child3['category_id'],
                            'name'        => $child3['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total3 . ')' : ''),
                            'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $child2['category_id'] . '_' . $child3['category_id'])
                        );
                    }

                    $children2_data[] = array(
                        'category_id' 		 => $child2['category_id'],
						'name'        		 => $child2_trimmed_name . ($this->config->get('config_product_count') ? ' (' . $product_total2 . ')' : ''),
                        'child3_id'   		 => $children3_data,
                        'href'        		 => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $child2['category_id'])
                    );
                }

				$children_data[] = array(
					'category_id' 		=> $child['category_id'],
					'name'        		=> $child_trimmed_name . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($data) . ')' : ''),
					'child2_id'   		=> $children2_data,
					'href'        		=> $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])	
				);		
			}

			$data = array(
				'filter_category_id'  => $category['category_id'],
				'filter_sub_category' => true
			);

			$this->data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $trimmed_name . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($data) . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);	
		}
		
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/category.tpl';
		} else {
			$this->template = 'default/template/module/category.tpl';
		}
		
		$this->render();
  	}
}
?>