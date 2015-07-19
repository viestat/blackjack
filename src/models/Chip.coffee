class window.Chip extends Backbone.Model
  initialize: (params) ->
    @set 
      id: params.id
      value: params.value
