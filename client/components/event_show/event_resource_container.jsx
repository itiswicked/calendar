import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

import ResourceCategory from './resource_category.jsx';

export default class EventResourceContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentWillMount() {
    this.getResourceAndFormInfo.bind(this);
    // this.interval = setInterval(this.getResourceAndFormInfo, this.state.pollInterval);
  }

  getResourceAndFormInfo() {
    debugger;
    var url = "/api" + this.props.event_url;
    $.ajax({
      url: url,
      method: 'GET',
      success: (responseData) => {
        this.setState({resources: responseData});
      },
      error: (xhr, status, err) => {
        console.error(url, status, err.toString());
      }
    });
  }

  render() {
    return(
      <div>
        <ResourceCategory resources={this.state.sound} category="Sound" />
        <ResourceCategory resources={this.state.lighting} category="Lighting" />
        <ResourceCategory resources={this.state.scenic} category="Scenic" />
        <ResourceCategory resources={this.state.wardrobe} category="Wardrobe" />
        <ResourceCategory resources={this.state.catering} category="Catering" />
      </div>
    );
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }
}
