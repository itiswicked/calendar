import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

export default class ResoureCategory extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <h1>Hello world from {this.props.category}</h1>
    );
  }
}
