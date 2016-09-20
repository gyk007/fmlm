<?php
class ControllerModuleBestSeller extends Controller {
	protected function index($setting) {
		$this->language->load('module/bestseller');
 
      	$this->data['heading_title'] = $this->language->get('heading_title');
				
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/product');
		
		$this->load->model('tool/image');
        
        $this->data['position'] = $setting['position'];	

		$this->data['products'] = array();
        
        $limit_days_new_product = 31;

		$limit_viewed_popular_product = 5;
        
        $timestamp 			= time();
		$date_time_array 	= getdate($timestamp);
		$hours 				= $date_time_array['hours'];
		$minutes 			= $date_time_array['minutes'];
		$seconds 			= $date_time_array['seconds'];
		$month 				= $date_time_array['mon'];
		$day 				= $date_time_array['mday'];
		$year 				= $date_time_array['year'];

		$timestamp = mktime($hours, $minutes, $seconds, $month,$day - $limit_days_new_product, $year);
        

		$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);
		
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
			} else {
				$image = false;
			}
            
            $set1 = $setting['image_width'] + 200; // Ўирина зум изображени€ основного фото
            $set2 = $setting['image_height']/$setting['image_width']*$set1; // ¬ысота зум изображени€ основного фото
            
            if ($result['image']) {
                    
				$image2 = $this->model_tool_image->resize($result['image'], $set1, $set2); 
			} else {
				$noimage = 'no_image.jpg';
				$image2 = $this->model_tool_image->resize($noimage, $set1, $set2);
			}
			
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}
					
			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}	
			
			if ($this->config->get('config_review_status')) {
				$rating = $result['rating'];
			} else {
				$rating = false;
			}
            
            $imgs = $this->model_catalog_product->getProductImages($result['product_id']);
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
            
            if ((float)$result['special']) {
						if ($result['price'] > 0) {
							$sale = '<div class="stiker-module-special"></div>';
						} else {
							$sale = false;
						}	
					} else {
						$sale = false;
					}			

				
				

					if (($result['date_available']) > strftime('%Y-%m-%d',$timestamp)) {
						$new = '<div class="stiker-module-new"></div>';
					} else {
						$new = false;
					}

				


				if (($result['viewed']) > ($limit_viewed_popular_product)) {
					        if ((float)$result['special']) {
                                $popular = '<div class="stiker-module-popular"></div>';
                                }
                            else {
                                $popular = '<div class="stiker-module-popular stikernospecial"></div>';
                            }
                      
                     
					} else {
						$popular = false;
					}
							
			$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'images' 	 => $imgt,
				'thumb'   	 => $image,
				'image2'   	 => $image2,
				'name'    	 => $result['name'],
				'price'   	 => $price,
				'special' 	 => $special,
                'attribute_groups' => $this->model_catalog_product->getProductAttributes($result['product_id']),
				'rating'     => $rating,
                'sale' 	  	 => $sale,
				'new'     	 => $new,
				'popular'    => $popular,
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/bestseller.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/bestseller.tpl';
		} else {
			$this->template = 'default/template/module/bestseller.tpl';
		}

		$this->render();
	}
}
?>