# * Methods *

random = (array) ->
  return array[Math.floor(Math.random()*array.length)]
  
rooturl = (path) ->
  root = window.location.href.match(/https?\:\/\/[^\/]+\//i)
  root + path

randomComment = () ->
  comments = [ 'Awesome!', 'I love this.', 'Really liking this particular piece. Incredible style, great execution. I love it! Where can I get it?', 'Fantastic.', 'Stunning.', 'Oh wow this is great!' ]
  images = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg"]
  handles = ["sofiakarlberg", "siucheukk", "emmaroberts6", "idalaerke", "primprima", "chiaraferragni"]
  you = [false, false, false, true]
  return {
    message: random(comments),
    image: "/placeholders/users/#{random(images)}"
    you: random(you)
    handle: random(handles)
  }

randomInterest = () ->
  labels = ['Turquoise and white', 'Bold crochet', 'DIOR', 'Jumper', 'yes', 'Chanel necklace', 'Forty Ounce Re-Stock', "Let's Bottle Bohemia found on Polyvore"]
  images = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg"]
  image = random(images)
  return {
    label: random(labels)
    image: "/placeholders/products/#{image}"
    price: Math.round((Math.random() * 100)),
    added: new Date()
  }
  
refreshMosiacs = () ->
  $('section.mosiac').each () ->
    $(this).imagesLoaded () ->
      setTimeout =>        
        $(this)
          .isotope('reloadItems')
          .isotope({sortBy: 'original-order'})
      , 500
      
params = (get) ->
  hash = {}
  querystring = location.search.replace( '?', '' ).split( '&' );
  for param in querystring
    [key, value] = param.split( '=' )
    hash[key] = value
  if get then hash[get] else hash
  
modal =
  el: ->
    return $('section.modal')
    
  content: ->
    return modal.el().find('.content')
    
  open: (template) ->
    $view    = Meteor.ui.render ->
      return Template[template]()

    modal.content().html($view)
    modal.show()

    return modal.el()
    
  close: ->
    Router.navigate('/', {trigger: true})
    modal.hide()
  
  show: ->
    modal.el().addClass('show')
    
  hide: ->
    modal.el().removeClass('show')


# * Footer *

Template.footer.swervd = () ->
  url = window.location.href.match(/https?\:\/\/[^\/]+\//i)
  
  # url = rooturl("js/push.js?r='+Math.random()*99999999")
  return """
    javascript:void((
      function(){
        var e = document.createElement('script');
        e.setAttribute('type','text/javascript');
        e.setAttribute('charset','UTF-8');
        e.setAttribute('src','#{url}js/push.js?r='+Math.random()*99999999);
        document.body.appendChild(e);
      })()
    );
  """

# * Modals *

Template.modal.events =
  'click .modal.show': (event) ->
    if( event.target == event.currentTarget )
      modal.close()

# * Methods *

Template.feature.events =
  'click': (event) ->
    event.preventDefault()
    Interests.insert randomInterest()

# * Views *

Template.views.viewis = (view) ->
  Session.equals('view', view)

# * Interests *

Template.interests.interests = ->
  query = Interests.find({}, {sort: {added: -1}})
  
  query.observe
    added: (interest) ->
      refreshMosiacs()
  
  return query
  
Template.interest.events =
  'click': ->
    Router.navigate "/interests/#{this._id}", {trigger: true}

Template.showInterest.comments = ->
  return Comments.find({ interest_id: Session.get('interestId') })
  
Template.showInterest.model = ->
  return Interests.findOne( Session.get('interestId') ) or {}

Template.newComment.events =
  'submit': (event) ->
    $comment = $('form.new-comment input')
    
    Comments.insert
      interest_id: Session.get('interestId')
      message: $comment.val()
      handle: 'anonymous'
      image: '/placeholders/users/none.jpg'
      user_id: Session.get('userId')

    $comment.val('')
    
    $element = $('.modal.show')
    $element.animate({scrollTop: $element.prop('scrollHeight') }, 350)

    event.preventDefault()

Template.newComment.message = ->
  return Session.get('newComment')
  
Template.comment.ownerClass = () ->
  if( Session.get('userId') == this.user_id )
    return "you"
    
Template.comment.handle = () ->
  if( Session.get('userId') == this.user_id )
    return "You"
  else
    return this.handle
    
# * External Add *

Template.interestsExternal.events =
  'submit': (event) ->
    event.preventDefault()
    $form  = $(event.target)
    attrs  =      
      image: $form.find('input.url').val()
      label: $form.find('input.label').val()
      added: new Date
    
    Interests.insert attrs, () ->
      window.close()

Template.interestsExternal.image = () ->
  return Session.get('params').image

# * Routes *

SwerveRouter = Backbone.Router.extend
  routes:
    '': 'root'
    'interests/external': 'externalInterest'
    'interests/:id': 'interest'
  
  root: ->
    modal.hide()
  
  interest: (id) ->
    Session.set('interestId', id)
    modal.open 'showInterest'
    
  externalInterest: (params) ->
    Session.set('params', params)
    Session.set('view', 'interestsExternal')

Router = new SwerveRouter

# * Ready *
Meteor.startup () ->

  # Mosiacs
  $('section.mosiac').each () ->
    $(this).imagesLoaded () ->
      $(this).isotope
        itemSelector : '.item',
        masonry:
          columnWidth: 200
          gutterWidth: 10
  
  # History
  Backbone.history.start(pushState: true);