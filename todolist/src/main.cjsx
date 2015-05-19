React = require 'react'

App = React.createClass
  getInitialState: ->
    message: ''
    savedMessages: []
    
  componentDidMount: ->
    @setState          
      savedMessages: @fetchMessage()
        
  fetchMessage: ->
    data = localStorage.getItem("todos")
    try
      unless data?
        return []
      parseData = JSON.parse(data)
      console.log(parseData)
      return parseData
    catch
      return []
      
  updateMessage: (msg) ->
    @setState
      message: msg

  saveMessage: (msg) ->
    msgs = @state.savedMessages.concat msg
    localStorage.setItem("todos", JSON.stringify(msgs))
    @setState
      savedMessages: msgs

  render: ->
    <div>
      <Hello name="foo" />
      <MessageInput
       onChange={@updateMessage}
       onSave={@saveMessage} />
      <Message
       message={@state.message}
       savedMessages={@state.savedMessages} />
    </div>

Hello = React.createClass
  getInitialState: ->
    count:0
  onClick: (e) ->
    @setState
        count: @state.count + 1
  render: ->
    <div><span onClick={@onClick}>Hello {@props.name}</span><span>{@state.count}</span></div>
            
MessageInput = React.createClass

  onChange: (e) ->
    @props.onChange e.target.value

  onKeyDown: (e) ->
    if e.keyCode is 13
      @props.onSave e.target.value
      e.target.value = ''

  render: ->
    <input type="text"
     onChange={@onChange}
     onKeyDown={@onKeyDown} />

Message = React.createClass
  render: ->
    i = 0
    msgs = @props.savedMessages.map (msg) ->
      <li key={i++}>{msg}</li>

    <div>
      <p>{@props.message}</p>
      <ul>{msgs}</ul>
    </div>

React.render <App />
, document.getElementById 'app-container'
