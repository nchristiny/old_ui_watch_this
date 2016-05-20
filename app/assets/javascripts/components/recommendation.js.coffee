@Recommendation = React.createClass
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/recommendations/#{ @props.recommendation.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecommendation @props.recommendation
   render: ->
     React.DOM.tr null,
       React.DOM.td null, @props.recommendation.winning_title
       React.DOM.td null, rating_prefFormat(@props.recommendation.rating_pref)
       React.DOM.td null, @props.recommendation.genres_pref
       React.DOM.td null, @props.recommendation.director_pref
       React.DOM.td null, @props.recommendation.stars_pref
       React.DOM.td null, @props.recommendation.keywords_pref
       React.DOM.td null, @props.recommendation.decade_pref
       React.DOM.td null,
         React.DOM.a
           className: 'btn btn-danger'
           onClick: @handleDelete
           'Delete'
