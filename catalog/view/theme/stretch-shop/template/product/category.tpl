<?php

$imagezoom="1"; //≈сли установлено "1", то будет эффект зума при наведении на странице  атегории
                 //≈сли установлено "0", то не будет эффекта зума при наведении на странице  атегории

$hoveradditional='1';  //≈сли указать "1", то будут внизу товара при надении на него отображатьс€ блок с дополнительными изображени€ми и 		атрибутами на странице  атегории
                    //≈сли указать "0", то не будут внизу товара при надении на него отображатьс€ блок с дополнительными изображени€ми и атрибутами на странице  атегории
                 
                
//ѕеречисленна€ ниже настройка работает только при включенном значении $hoveradditional
$additionalimage='1';  //≈сли указать "1", то будут отображатьс€ дополнительные изображени€ товара в списке товаров на странице  атегории
                    //≈сли указать "0", то не будут отображатьс€ дополнительные изображени€ товара в списке товаров на странице  атегории

?>


<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <?php if ($thumb || $description) { ?>
  <div class="category-info">
    <?php if ($thumb) { ?>
    <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
    <?php } ?>
    <?php if ($description) { ?>
    <?php echo $description; ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php if ($categories) { ?>
  <h2><?php echo $text_refine; ?></h2>
  <div class="category-list">
    <?php if (count($categories) <= 5) { ?>
    <ul>
      <?php foreach ($categories as $category) { ?>
      <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
      <?php } ?>
    </ul>
    <?php } else { ?>
    <?php for ($i = 0; $i < count($categories);) { ?>
    <ul>
      <?php $j = $i + ceil(count($categories) / 4); ?>
      <?php for (; $i < $j; $i++) { ?>
      <?php if (isset($categories[$i])) { ?>
      <li><a href="<?php echo $categories[$i]['href']; ?>"><?php echo $categories[$i]['name']; ?></a></li>
      <?php } ?>
      <?php } ?>
    </ul>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
  <div class="product-filter">
    <div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
    <div class="limit"><b><?php echo $text_limit; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($limits as $limits) { ?>
        <?php if ($limits['value'] == $limit) { ?>
        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
    <div class="sort"><b><?php echo $text_sort; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
  </div>
  <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
  <div class="product-list">
                    <?php if ($hoveradditional=="0" and $imagezoom=="0") {$additionalimage='0';} ?>
                    <?php if ($hoveradditional=="1" and $imagezoom=="0") {$additionalimage='0';} ?>
                    <?php $m=0; ?>
					<?php foreach ($products as $product) { ?>
						<?php $m=$m+1; ?>
						<div>
							<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
							<div class="description"><?php echo $product['description']; ?></div>							
							<?php if ($product['thumb']) { ?>
								<div class="image">
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
							<?php if ($product['rating']) { ?>
							<div class="rating" <?php if ($hoveradditional=="0") { ?> style="display: block;" <?php } ?> ><img src="catalog/view/theme/stretch-shop/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
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
                           <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a></div>
						   <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a></div> 
						</div>
					<?php } ?>
  </div>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.product-list > div').each(function(index, element) {
			html  = '<div class="right">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			html += '</div>';			
			
			html += '<div class="left">';
			
			var image = $(element).find('.image').html();
			
			if (image != null) { 
				html += '<div class="image" <?php if ($imagezoom=="0") { ?> style="width: auto;" <?php } ?> >' + image + '</div>';
			}
			
            <?php if ($hoveradditional=="1") { ?>
			     html += '<div class="hoverblock" style="display: none;">' + $(element).find('.hoverblock').html() + '</div>';
            <?php } ?>
            
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
					
			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			html += '</div>';

						
			$(element).html(html);
		});		
		
		$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		$.cookie('display', 'list'); 
		
		$.getScript('catalog/view/javascript/cloud-zoom.1.0.2.js');  
		
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > div').each(function(index, element) {
			html = '';
			
			var image = $(element).find('.image').html();
			
			if (image != null) {
				html += '<div class="image" <?php if ($imagezoom=="0") { ?> style="width: auto;" <?php } ?> >' + image + '</div>';
			}
			
			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
            
            var price = $(element).find('.price').html();

            <?php if ($hoveradditional=="0") { ?>
			if (price != null) {
				html += '<div class="price" style="display: block;">' + price  + '</div>';
			}
            <?php } ?>
            <?php if ($hoveradditional=="1") { ?>
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
            <?php } ?>
            
			
			
            		
			var cart = $(element).find('.cart').html();
            
            <?php if ($hoveradditional=="0") { ?>
			if (price != null) {
				html += '<div class="cart" style="display: block;">' + cart  + '</div>';
			}
            <?php } ?>
            <?php if ($hoveradditional=="1") { ?>
			if (price != null) {
				html += '<div class="cart">' + cart  + '</div>';
			}
            <?php } ?>
			
            
            <?php if ($hoveradditional=="1") { ?>
			     html += '<div class="hoverblock">' + $(element).find('.hoverblock').html() + '</div>';
			<?php } ?>
            
			html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';
			
			$(element).html(html);
		});	
					
		$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		$.cookie('display', 'grid');
		
		$.getScript('catalog/view/javascript/cloud-zoom.1.0.2.js');  
		
	}
}

view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('grid');
}
//--></script> 
<?php echo $footer; ?>