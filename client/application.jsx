import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

import EventResourceContainer from './components/event_show/event_resource_container.jsx';

ready(renderReactCompenents);

function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function renderReactCompenents() {
  render(
    <EventResourceContainer event_url={window.location.pathname} pollInterval={2000} />,
    document.getElementById('event-resources-container')
  );
}
