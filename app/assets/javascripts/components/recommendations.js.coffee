@Recommendations = React.createClass
  getInitialState: ->
    recommendations: @props.data
  getDefaultProps: ->
    recommendations: []
  addRecommendation: (recommendation) ->
    recommendations = React.addons.update(@state.recommendations, { $push: [recommendation] })
    @setState recommendations: recommendations
  # componentWillReceiveProps: (nextProps) -> @addRecommendation nextProps.params
  # componentDidMount: -> @addRecommendation @props.params
  deleteRecommendation: (recommendation) ->
    index = @state.recommendations.indexOf recommendation
    recommendations = React.addons.update(@state.recommendations, { $splice: [[index, 1]] })
    @replaceState recommendations: recommendations
  render: ->
    React.DOM.div
      className: 'recommendations'
      React.DOM.h2
        className: 'title'
        'Recommendations'
      React.createElement RecommendationForm, handleNewRecommendation: @addRecommendation
      React.DOM.hr null
      React.DOM.table
        className: 'table table-striped'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Winning Title'
            React.DOM.th null, 'Rating Preference'
            React.DOM.th null, 'Genres Preference'
            React.DOM.th null, 'Director Preference'
            React.DOM.th null, 'Stars Preference'
            React.DOM.th null, 'Keywords Preference'
            React.DOM.th null, 'Decade Preference'
            React.DOM.th null, ''
        React.DOM.tbody null,
          for recommendation in @state.recommendations
            React.createElement Recommendation, key: recommendation.id, recommendation: recommendation, handleDeleteRecommendation: @deleteRecommendation
