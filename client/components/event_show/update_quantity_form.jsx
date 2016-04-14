import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

export default class QuantityUpdateForm extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <form>
        <div className="resource-update-quantity">
          <div className="resource-update-quantity-field-container">
            <input
              type="text"
              className="resource-update-quantity-field"
              value={this.props.quantity}
            />
          </div>
          <div className="resource-update-quantity-field-submit-container">
            <a href="#"className="resource-update">
              <i className="material-icons">done</i>
            </a>
          </div>
        </div>
      </form>
    );
  }

}
