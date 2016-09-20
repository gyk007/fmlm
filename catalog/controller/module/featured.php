<?php
class ControllerModuleFeatured extends Controller {
	protected function index($setting) {
		$this->language->load('module/featured'); 

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/product'); 
		
		$this->load->model('tool/image');

		$this->data['products'] = array();

		$products = explode(',', $this->config->get('featured_product'));
		
		$this->data['position'] = $setting['position'];	
		
		if (empty($setting['limit'])) {
			$setting['limit'] = 5;
		}
        
        $limit_days_new_product = 31;

		$limit_viewed_popular_product = 5;

		
		$products = array_slice($products, 0, (int)$setting['limit']);
        
        $timestamp 			= time();
		$date_time_array 	= getdate($timestamp);
		$hours 				= $date_time_array['hours'];
		$minutes 			= $date_time_array['minutes'];
		$seconds 			= $date_time_array['seconds'];
		$month 				= $date_time_array['mon'];
		$day 				= $date_time_array['mday'];
		$year 				= $date_time_array['year'];

		$timestamp = mktime($hours, $minutes, $seconds, $month,$day - $limit_days_new_product, $year);
		
		$products = array_slice($products, 0, (int)$setting['limit']);
		
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
				} else {
					$image = false;
				}
				
				$set1 = $setting['image_width'] + 200; // Ўирина зум изображени€ основного фото
            $set2 = $setting['image_height']/$setting['image_width']*$set1; // ¬ысота зум изображени€ основного фото
            
                if ($product_info['image']) {
                    
					$image2 = $this->model_tool_image->resize($product_info['image'], $set1, $set2); 
				} else {
				    $noimage = 'no_image.jpg';
					$image2 = $this->model_tool_image->resize($noimage, $set1, $set2);
				}
				
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = $product_info['rating'];
				} else {
					$rating = false;
				}
				
				$imgs = $this->model_catalog_product->getProductImages($product_info['product_id']);
				$imgt = array();
				
				$set3 = $setting['image_width'] + 200; // Ўирина зум изображени€ дополнительных фото
                $set4 = $setting['image_height']/$setting['image_width']*$set3; // ¬ысота зум изображени€ дополнительных фото
				
				foreach ($imgs as $imgi) {
					$imgt[] = array(
						'popup' => $this->model_tool_image->resize($imgi['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
						'thumb' => $this->model_tool_image->resize($imgi['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),
						'thumb1' => $this->model_tool_image->resize($imgi['image'], $setting['image_width'], $setting['image_height']), // –есайз дополнительного зум изображени€ при клике на иконку дополнительного изображени€
						'thumb2' => $this->model_tool_image->resize($imgi['image'], $set3, $set4)  // –есайз дополнительного зум изображени€ товара при наведении
					);
				}
                
                if ((float)$product_info['special']) {
						if ($product_info['price'] > 0) {
							$sale = '<div class="stiker-module-special"></div>';
						} else {
							$sale = false;
						}	
				} else {
						$sale = false;
				}			

				
				

                if (($product_info['date_available']) > strftime('%Y-%m-%d',$timestamp)) {
						$new = '<div class="stiker-module-new"></div>';
                } else {
						$new = false;
				}

				


				if (($product_info['viewed']) > ($limit_viewed_popular_product)) {
					    if ((float)$product_info['special']) {
                            $popular = '<div class="stiker-module-popular"></div>';
                        }
                        else {
                            $popular = '<div class="stiker-module-popular stikernospecial"></div>';
                        }
				} else {
						$popular = false;
				}
					
				$this->data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'images' 	 => $imgt,
					'thumb'   	 => $image,
					'image2'   	 => $image2,
					'name'    	 => $product_info['name'],
					'price'   	 => $price,
					'special' 	 => $special,
					'attribute_groups' => $this->model_catalog_product->getProductAttributes($product_info['product_id']),
					'rating'     => $rating,
                    'sale' 	  	  => $sale,
					'new'     	  => $new,
					'popular'     => $popular,
					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'href'    	 => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
				);
			}
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/featured.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/featured.tpl';
		} else {
			$this->template = 'default/template/module/featured.tpl';
		}

		$this->render();
	}
}
?>