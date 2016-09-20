<?php

$imagezoom="1"; //≈сли установлено "1", то будет эффект зума при наведении в модуле ѕоследние поступлени€
                 //≈сли установлено "0", то не будет эффекта зума при наведении в модуле ѕоследние поступлени€

$hoveradditional='1';  //≈сли указать "1", то будут внизу товара при надении на него отображатьс€ блок с дополнительными изображени€ми и 		атрибутами в модуле ѕоследние поступлени€
                    //≈сли указать "0", то не будут внизу товара при надении на него отображатьс€ блок с дополнительными изображени€ми и атрибутами в модуле ѕоследние поступлени€
                 
                
//ѕеречисленна€ ниже настройка работает только при включенном значении $hoveradditional
$additionalimage='1';  //≈сли указать "1", то будут отображатьс€ дополнительные изображени€ товара в списке товаров в модуле ѕоследние поступлени€
                    //≈сли указать "0", то не будут отображатьс€ дополнительные изображени€ товара в списке товаров в модуле ѕоследние поступлени€

?>

	<?php if ($position == 'content_top'  or $position == 'content_bottom') { ?>
		<div class="box">
			<div class="box-heading"><?php echo $heading_title; ?></div>
			<div class="box-content">
				<div class="box-product">
                    <?php if ($hoveradditional=="0" and $imagezoom=="0") {$additionalimage='0';} ?>
                    <?php if ($hoveradditional=="1" and $imagezoom=="0") {$additionalimage='0';} ?>
					<?php $m=200; ?>
					<?php foreach ($products as $product) { ?>
						<?php $m=$m+1; ?>
						<div>
								
							<?php if ($product['thumb']) { ?>
								<div class="image" <?php if ($imagezoom=="0") { ?> style="width: auto;" <?php } ?> >
									<?php if ($hoveradditional=="1" and $imagezoom=="1") { ?>
    										<a href="<?php echo $product['image2']; ?>" class="cloud-zoom" id='zoom<?php echo $m; ?>' rel="position: 'inside' ,showTitle: false, adjustX:0, adjustY:0">
    										<img src="<?php echo $product['thumb']; ?>" />
    										</a>
    									<?php } ?>
                                        <?php if ($hoveradditional=="0" and $imagezoom=="1") { ?>
    										<a href="<?php echo $product['image2']; ?>" class="cloud-zoom" id='zoom<?php echo $m; ?>' rel="position: 'inside' ,showTitle: false, adjustX:0, adjustY:0">
    										<img src="<?php echo $product['thumb']; ?>" />
    										</a>
    									<?php } ?>
                                        <?php if ($hoveradditional=="1" and $imagezoom=="0") { ?>
    										<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
    										</a>
    									<?php } ?>
                                        <?php if ($hoveradditional=="0" and $imagezoom=="0") { ?>
                                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                        <?php } ?>
                                        <?php echo $product['sale']; ?><?php echo $product['new']; ?><?php echo $product['popular']; ?>
								</div>
							<?php } ?>
							<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
							<?php if ($product['rating']) { ?>
							<div class="rating" <?php if ($hoveradditional=="0") { ?> style="display: block;" <?php } ?> ><img src="catalog/view/theme/stretch-shop/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
							<?php } ?>
                            <?php if ($product['price']) { ?>
							<div class="price" <?php if ($hoveradditional=="0") { ?> style="display: block;" <?php } ?> >
							  <?php if (!$product['special']) { ?>
							  <?php echo $product['price']; ?>
							  <?php } else { ?>
							  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
							  <?php } ?>
							</div>
							<?php } ?>
							
							<div class="cart" <?php if ($hoveradditional=="0") { ?> style="display: block;" <?php } ?> ><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
							<?php if ($hoveradditional=="1") { ?>
								<div class="hoverblock">
                                       <?php if ($additionalimage=="1") { ?> 
    										<div class="additional-image">
    											<?php $n=0; ?>
    											<?php if ($product['images']) { ?>
    												
    												
    													<?php if ($imagezoom=="1") { ?>
    												
    															<a href="<?php echo $product['image2']; ?>" title="<?php echo $product['name']; ?>" class="cloud-zoom-gallery" rel="useZoom: 'zoom<?php echo $m; ?>', smallImage: '<?php echo $product['thumb']; ?>' "><img width="31px" height="42px" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
    															<?php foreach ($product['images'] as $image) { ?>
    																<?php $n=$n+1; ?>
    																	<?php if ($n<=4) { ?>
    																		<a href="<?php echo $image['thumb2']; ?>" title="<?php echo $product['name']; ?>" class="cloud-zoom-gallery" rel="useZoom: 'zoom<?php echo $m; ?>', smallImage: '<?php echo $image['thumb1']; ?>' "><img width="31px" height="42px" src="<?php echo $image['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
    																	<?php } ?>	
    															<?php } ?>
    													
    													<?php } ?>
    													
    													<?php if ($imagezoom=="0") { ?>
    												
    															<a href="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" class="cloud-zoom-gallery" rel="useZoom: 'zoom<?php echo $m; ?>', smallImage: '<?php echo $product['thumb']; ?>' "><img width="31px" height="42px" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
    															<?php foreach ($product['images'] as $image) { ?>
    																<?php $n=$n+1; ?>
    																	<?php if ($n<=4) { ?>
    																		<a href="<?php echo $image['thumb1']; ?>" title="<?php echo $product['name']; ?>" class="cloud-zoom-gallery" rel="useZoom: 'zoom<?php echo $m; ?>', smallImage: '<?php echo $image['thumb1']; ?>' "><img width="31px" height="42px" src="<?php echo $image['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
    																	<?php } ?>	
    															<?php } ?>
    													
    													<?php } ?>
    													
    												<?php } ?>
    												
    											
    										</div>
                                        <?php } ?>
										<?php if ($product['price']) { ?>
											<div class="price">
											  <?php if (!$product['special']) { ?>
											  <?php echo $product['price']; ?>
											  <?php } else { ?>
											  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
											  <?php } ?>
											</div>
										<?php } ?>

										<div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
								 
										<?php if($product['attribute_groups']) { ?>
											<div class="atribute">
												<?php foreach($product['attribute_groups'] as $attribute_group) { ?>
														<br /><?php echo $attribute_group['name'].':'; ?><br />
																<?php foreach($attribute_group['attribute'] as $attribute) { ?>
																		<b><?php if ($attribute['text']) {echo $attribute['name'].':'; } else { echo $attribute['name'].' | '; } ?></b>
																		<?php IF ($attribute['text']) { echo $attribute['text'].' | '; } ?>
																		<?php } ?>
												<?php } ?>
											</div>
										<?php } ?>
								</div>
							<?php } ?>
						</div>
					<?php } ?>
				</div>
			</div>
		</div>
	<?php } else if ($position == 'column_left' or $position == 'column_right') { ?>
		<div class="box">
			<div class="box-heading"><?php echo $heading_title; ?></div>
			<div class="box-content">
				<div class="box-product">
				  <?php foreach ($products as $product) { ?>
				  <div>
					<?php if ($product['thumb']) { ?>
					<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
					<?php } ?>
					<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
					<?php if ($product['price']) { ?>
					<div class="price">
					  <?php if (!$product['special']) { ?>
					  <?php echo $product['price']; ?>
					  <?php } else { ?>
					  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
					  <?php } ?>
					</div>
					<?php } ?>
					<?php if ($product['rating']) { ?>
					<div class="rating"><img src="catalog/view/theme/stretch-shop/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
					<?php } ?>
					<div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
				  </div>
				  <?php } ?>
				</div>
			</div>
		</div>
	<?php } ?>