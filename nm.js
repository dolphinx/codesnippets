var Nightmare = require('nightmare');
var nightmare = Nightmare({ show: false })

nightmare
  .goto('https://test.com')
  .evaluate(function () {
  delete window.Buffer;
  })
  /*.type('form[action*="/search"] [name=p]', 'github nightmare')
  .click('form[action*="/search"] [type=submit]')
  .wait('#main')*/
  .evaluate(function () {
	var log = '';
	log += JSON.stringify(process);
	log += '\n';
	log += 'debugger:' + (window.console && window.console.firebug ? 2 : '__IE_DEVTOOLBAR_CONSOLE_COMMAND_LINE' in window ? 4 : 'console' in window && 'onhelp' in window ? 4 : window.outerHeight && window.innerHeight && window.outerHeight - window.innerHeight > 200 ? 8 : 1);
	log += '\n';
	var em = [window.spawn,
	window.emit,
	window.Buffer,
	window.domAutomation,
	window.webdriver,
	document.__webdriver_script_fn,
	document['$cdc_asdjflasutopfhvcZLmcfl_'],
	document.documentElement.getAttribute('webdriver'),
	window.fxdriver_id,
	window.__fxdriver_unwrapped,
	window.ClientUtils,
	window._phantom,
	window.callPhantom,
	window.phantom];
	var emstr = 'emulator:';
	for (var i = 0; i < em.length; ++i)
		emstr += '' + (em[i] ? 1 : 0);
	log += emstr;
	return log;
  })
  .end()
  .then(function (result) {
    console.log(result)
  })
  .catch(function (error) {
    console.error('Search failed:', error);
});