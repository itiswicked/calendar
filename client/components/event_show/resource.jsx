import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

export default class Resource extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentWillMount() {
    this.setState({resource: this.props.resource});
  }

  render() {
    return(
      <tr className="resource-row">
        <td className="resource-column">{this.state.resource.name}</td>
        <td className="notes-column">-</td>
        <td className="quantity-column">
          <span>{this.state.resource.quantity}</span>
          <div className="resource-buttons">
            <a href="#" className="resource-edit">
              <i className="material-icons">create</i>
            </a>
            <a href="#" className="resource-edit">
              <i className="material-icons delete">clear</i>
            </a>
          </div>
        </td>
      </tr>
    );
  }
}
