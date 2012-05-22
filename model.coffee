# Helpers

uid = () ->
  chars = "0123456789"
  length = 17
  string = ""

  while length -= 1
    index = Math.floor(Math.random() * chars.length)
    string += chars.substring(index, index+1)

  return string

# Session

Session.set('userId', uid())

# * Models *

Interests = new Meteor.Collection("interests");
Comments  = new Meteor.Collection("comments");