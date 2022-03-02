
function component() {
  const element = document.createElement('div');
  element.innerHTML = 'Hello Rehax!';
  return element;
}

document.body.appendChild(component());
