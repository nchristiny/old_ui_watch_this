@RecommendationForm = React.createClass
  getInitialState: ->
    winning_title: ''
    rating_pref: ''
    genres_pref: ''
    director_pref: ''
    decade_pref: ''
    keywords_pref: ''
    stars_pref: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.rating_pref && @state.genres_pref && @state.director_pref && @state.decade_pref && @state.keywords_pref && @state.stars_pref
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { recommendation: @state }, (data) =>
      console.log('Hello from POST')
      @props.handleNewRecommendation data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'hidden'
          className: 'form-control'
          name: 'winning_title'
          value: @state.winning_title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          min: '1'
          max: '10'
          className: 'form-control'
          placeholder: 'Rating Preference'
          name: 'rating_pref'
          value: @state.rating_pref
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Genres Preference'
          name: 'genres_pref'
          value: @state.genres_pref
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Director Preference'
          name: 'director_pref'
          value: @state.director_pref
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Stars Preference'
          name: 'stars_pref'
          value: @state.stars_pref
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Keywords Preference'
          name: 'keywords_pref'
          value: @state.keywords_pref
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Decade Preference'
          name: 'decade_pref'
          value: @state.decade_pref
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create new recommendation'
