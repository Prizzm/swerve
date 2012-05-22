(function () {
  
  if( document.getElementById('_swervd') ) 
    return false;
  
  (function () {
    
    // * Determine correct url *
    
    var scripts = document.getElementsByTagName("script");
    var source = scripts[scripts.length-1].src;
    var root   = source.match(/https?\:\/\/[^\/]+\//i);

    // * Functions *

    var f = function (string) {  
      var args = arguments;  
      var pattern = new RegExp("%([1-" + arguments.length + "])", "g");  
      return String(string).replace(pattern, function(match, index) {  
        return args[index];  
      });
    }

    var getImages = function () {
      var images = []
      for (var i=0; i < document.images.length; i++) {
        var image = document.images[i];
        // console.lo
        if( image.clientWidth >= 150 || image.clientHeight >= 150 )
          images.push(image)
      };
      return images;
    }

    var tag = function (type, options, func) {
      var element = document.createElement(type);
      for( var prop in options )
        element.setAttribute(prop, options[prop])
      if( func ) element.appendChild(func.call(element))
      return element;
    }

    var findbytype = function (type) {
      return document.getElementsByTagName(type)[0];
    }

    var text = function (string) {
      return document.createTextNode(string)
    }

    var styles = function () {
      var args = Array.prototype.slice.call(arguments);
      var head = document.getElementsByTagName('head')[0];
      var style = tag('style', { type: 'text/css' })
      var rules = text(args.join("\n"))
      if(style.styleSheet) style.styleSheet.cssText = rules.nodeValue;
      else style.appendChild(rules);
      findbytype('head').appendChild(style);
    }

    var center = function (holder) {
      var width = 230
      var columns = Math.floor((window.innerWidth - 20) / width);
      holder.style.width = ((columns * width)) + "px";
    }
    
    var select = function (element, url) {
      var url = root + 'interests/external?image=' + url;
      window.open(url, "swerv'd", "location=0,status=0,scrollbars=0,width=500,height=600");
      close()
    }
    
    var close = function () {
      var swerver = document.getElementById('_swervd')
      swerver.parentElement.removeChild(swerver);
    }

    styles(
      '#_swervd, #_swervd * { margin: 0px; padding: 0; border: 0; font-size: 100%; vertical-align: baseline; line-height: 1em; list-style: none; font: normal 14px/20px "Helvetica Neue", Helvetica, Arial, sans-serif; font-weight: 300; background: transparent; }',
      '#_swervd { position:fixed; top: 0px; left: 0px; bottom: 0px; right: 0px; background: rgba(10,10,10,0.90); z-index:100000000; overflow: auto; opacity: 0.0; -moz-opacity: 0.0; filter:alpha(opacity=0); }',
      '#_swervd.show { opacity: 1; -moz-opacity: 1; filter:alpha(opacity=100); }',
      '#_swervd { transition: all 0.75s; -moz-transition: all 0.75s; -webkit-transition: all 0.75s; -o-transition: all 0.75s; }',
      '#_swervd a { text-decoration: none }', 
      '#_swervd .clearfix { clear: both }',
      '#_swervd .footer { position: fixed; bottom: 0px; left: 0px; right: 0px; height: 65px; line-height: 65px; background: #000; z-index: 100; text-align: center; }',
      '#_swervd .footer { -moz-box-shadow: 0px -3px 12px #000; -webkit-box-shadow: 0px -3px 12px #000; box-shadow: 0px -3px 12px #000; }',
      '#_swervd .footer { transition: all 0.2s; -moz-transition: all 0.2s; -webkit-transition: all 0.2s; -o-transition: all 0.2s; }',
      '#_swervd .footer a.brand { color: #fff; font-size: 30px; letter-spacing: -1px; text-transform: lowercase; font-weight: 300; }',
      '#_swervd .footer a.cancel { display: none; width: 100%; height: 65px; line-height: 65px; color: #fff; font-size: 20px; font-weight: 500; }',
      '#_swervd .footer:hover a.brand { display: none; }',
      '#_swervd .footer:hover a.cancel { display: block; }',
      '#_swervd .holder { margin: 10px auto; padding-bottom: 100px; }',
      '#_swervd .holder { transition: all 0.2s; -moz-transition: all 0.2s; -webkit-transition: all 0.2s; -o-transition: all 0.2s; }',
      '#_swervd .image { width: 200px; height: 200px; float: left; margin: 15px; text-align: center; }',
      '#_swervd .image .container { position: relative; display: table-cell; width: 200px; height: 200px; text-align: center; vertical-align: middle; }',
      '#_swervd .image img { transition: all 0.3s; -moz-transition: all 0.3s; -webkit-transition: all 0.3s; -o-transition: all 0.3s; }',
      '#_swervd .image img { -moz-box-shadow: 0px 2px 8px #000; -webkit-box-shadow: 0px 2px 8px #000; box-shadow: 0px 2px 8px #000; }',
      '#_swervd .image img { cursor: pointer; max-width: 200px; max-height: 200px; vertical-align: top; background: #fff; }',
      '#_swervd .image .add { position: absolute; top: 50%; left: 50%; margin-top: -50px; margin-left: -40px;  color: #fff; width: 80px; line-height: 30px; font-weight: bold; font-size: 12px; }',
      '#_swervd .image .add { -moz-border-radius: 15px; border-radius: 15px; background: rgba(0,0,0,0.9); opacity: 0.0; -moz-opacity: 0.0; filter:alpha(opacity=0); }',
      '#_swervd .image .add { -moz-box-shadow: 0px 2px 8px #000; -webkit-box-shadow: 0px 2px 8px #000; box-shadow: 0px 2px 8px #000; }',
      '#_swervd .image .add { transition: all 0.3s; -moz-transition: all 0.3s; -webkit-transition: all 0.3s; -o-transition: all 0.3s; }',
      '#_swervd .image:hover .add { margin-top: -15px; opacity: 1.0; -moz-opacity: 1.0; filter:alpha(opacity=100); }',
      '#_swervd .image:hover img { opacity: 0.6; -moz-opacity: 0.6; filter:alpha(opacity=60  ); }'
    );

    // Checks

    if( getImages().length == 0 ) 
      return alert("Looks like there's nothing to add here!");

    // Ready

    var images  = getImages();
    var swerver = tag('div', {id: '_swervd'});
    var footer = tag('div', {class: 'footer shadow'});
    var holder = tag('div', {class: 'holder'});
    var brand  = tag('a', {class: 'brand', href: 'http://swerve.im'}, 
      function () { return text('swerve') });
    var cancel = tag('a', {class: 'cancel', href: 'javascript:void(0);'},
      function () { return text('I changed my mind..') });
    
    // Appends..
    footer.appendChild(brand);
    footer.appendChild(cancel);
    swerver.appendChild(footer);
    swerver.appendChild(holder);

    // Add images..
    for (var i=0; i < images.length; i++) {

      var image = tag('div', {class: 'image'}, function () {
        
        var url  = images[i].src;
        var image = tag('img', { src: url })
        var link  = tag('div', {class: 'container'});
            link.appendChild(image);
            link.appendChild(tag('a', {href: 'javascript:void(0)', class:'add'}, function () {
              return text('Add it!');
            }));
        
        // Add..
        this.onclick = function () {
          select(image, url)
        }
            
        return link;
      })
      holder.appendChild(image)
    };
    
    // Add clearfix..
    holder.appendChild(tag('br', {class: 'clearfix'}));
    
    // Add to body..
    findbytype('body').appendChild(swerver);

    // Centering
    window.onresize = function () { center(holder) }
    center(holder)

    // On cancel..
    cancel.onclick = function () {
      close()
    }

    // Show..
    setTimeout(function () { 
      swerver.className += " show" 
    }, 100);
    
  })();
})();