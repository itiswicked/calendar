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
    this.getResourceData();
    this.interval = setInterval(
      this.getResourceData.bind(this),
      this.props.pollInterval
    );
  }

  getResourceData() {
    var url = "/api" + window.location.pathname;
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
    if (!this.state.resources) return<div></div>; // if there is no data to be displayed
    return(
      <div>
        <ResourceCategory resources={this.state.resources.sound} category="Sound" />
        <ResourceCategory resources={this.state.resources.lighting} category="Lighting" />
        <ResourceCategory resources={this.state.resources.scenic} category="Scenic" />
        <ResourceCategory resources={this.state.resources.wardrobe} category="Wardrobe" />
        <ResourceCategory resources={this.state.resources.catering} category="Catering" />
      </div>
    );
  }

  componentWilUnMount() {
    clearInterval(this.interval);
  }
}
