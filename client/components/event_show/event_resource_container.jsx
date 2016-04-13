import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

import ResourceCategory from './resource_category.jsx';

export default class EventResourceContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {resources: this.props.data};
  }

  render() {
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
}
