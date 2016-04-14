import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

export default class ResourceForm extends React.Component {
  constructor(props) {
    super(props);
  }

  options() {
    return this.props.options.map(option => {
      return <option value={option[1]}>{option[0]}</option>;
    });
  }

  render() {
    return(
      <form className="new_resource" id="new_resource">
        <input name="utf8" type="hidden" value="&#10003;" />
        <div className="row">
          <div className="small-6 columns resource-select">
            <label htmlFor="resource_inventory_item_id">Resource</label>
            <select
              className="select-box"
              name="resource[inventory_item_id]"
              id="resource_inventory_item_id"
            >
              {this.options()}
            </select>
          </div>
          <div className="small-6 columns">
            <div className="row">
              <div className="small-10 columns resource-quantity-field">
                <label htmlFor="resource-quantity">Quantity</label>
                <input class="quantity-box" type="text" name="resource[quantity]" id="resource_quantity" />
              </div>
              <div className="small-2 columns">
                <input type="submit" name="commit" value="Add" className="button resource-add-button" />
              </div>
            </div>
          </div>
        </div>
      </form>
    );
  }
}
