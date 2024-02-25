
var href = location.href;
var mvnContext = '';

if (validate(href)) {
	
	mvnContext = getContext(href);
	mvnContext = '/' + mvnContext;
	
	if (mvnContext == '/mvnplugin') {
		mvnContext = '';
	}
	
	if (mvnContext == '/pluto') {
		mvnContext = '/mvncms_portlet';
	}
	
	if (mvnContext == '/wps') {
		mvnContext = '/mvncms_portlet';
	}
	
}

function getContext(url) {
	var context = '';
	
	var index = url.indexOf('://');
	context = url.substring(index + 3);
	
	var slashIndex = context.indexOf('/');
	context = context.substring(slashIndex);
	
	slashIndex = context.indexOf('/');
	context = context.substring(1);
	
	slashIndex = context.indexOf('/');
	context = context.substring(0, slashIndex);
		
	return context;
}

function validate(url) {
	
	if (url.indexOf('<') != -1) {
		return false;
	}
	if (url.indexOf('>') != -1) {
		return false;
	}
	if (url.indexOf('\'') != -1) {
		return false;
	}
	if (url.indexOf('"') != -1) {
		return false;
	}
	if (url.indexOf('&') != -1) {
		return false;
	}
	
	return true;
}