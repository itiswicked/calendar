import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

import Resource from './resource.jsx';

export default class ResourceCategory extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      resources: [],
      options: []
    };
  }

  componentWillReceiveProps() {
    this.setState({
      resources: this.props.resources.resources,
      options: this.props.resources.options
    });
  }

  resourceRows() {
    return this.state.resources.map(resource => {
      return <Resource resource={resource} key={resource.id} />;
    });
  }

  render() {
    return(
      <article className="resource-category">
        <h3>{this.props.category}</h3>
        <table className="resource-table">
          <thead>
            <tr>
              <th className="resource-column">Resource</th>
              <th className="notes-column">Notes</th>
              <th className="quantity-column">Quantity</th>
            </tr>
          </thead>
          <tbody>
            {this.resourceRows()}
          </tbody>
        </table>
      </article>
    );
  }
}
