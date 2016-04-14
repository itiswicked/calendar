import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

import EventResourceContainer from './components/event_show/event_resource_container.jsx';

ready(renderReactComponents);

// Move AJAX back to where it was
// put if conditions in a render
// if state conditions are not met, reutnrn, else render component
function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function renderReactComponents() {
  render(
    <EventResourceContainer pollInterval={2000} />,
    document.getElementById('event-resources-container')
  );
}
