import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

export default class EventResourceContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {
    // get shit from server
    // get initial dropdow info
    // poll ONLY RESOURCE DATA
    this.getResourceInfoFromServer();
  }

  getResourceInfoFromServer() {
    var url = `/api${this.props.event_url}`;
    $.ajax({
      url: url,
      method: 'GET',
      success: (response) => {
        debugger;
      },
      error: (xhr, status, err) => {
        console.error(this.props.url, status, err.toString());
      }
    });
  }

  render() {
    return(
      <h1>Hello From Container!</h1>
    );
  }
}
