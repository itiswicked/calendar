import React from 'react';
import ReactDOM from 'react-dom';
import {render} from 'react-dom';

import EventResourceContainer from './components/event_show/event_resource_container.jsx';

ready(start);

function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function start() {
  getResourceDataFromServer();
  setInterval(getResourceDataFromServer, 2000);
}

function renderReactComponents(data) {
  render(
    <EventResourceContainer data={data} />,
    document.getElementById('event-resources-container')
  );
}

function getResourceDataFromServer() {
  var url = "/api" + window.location.pathname;
  $.ajax({
    url: url,
    method: 'GET',
    success: (responseData) => {
      renderReactComponents(responseData);
    },
    error: (xhr, status, err) => {
      console.error(url, status, err.toString());
    }
  });
}
