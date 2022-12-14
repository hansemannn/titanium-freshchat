import Freshchat from 'ti.freshchat';

// -------- Set your credentials here --------

const APP_ID = 'YOUR_APP_ID';
const APP_KEY = 'YOUR_APP_KEY';
const APP_DOMAIN = null; // optional

// -------- Set your credentials here --------

const window = Ti.UI.createWindow({ layout: 'vertical' });
window.addEventListener('open', () => initializeSDK());

addButton('Sign in user', signInUser);
addButton('Update user', updateUser);
addButton('Reset user', signOutUser);
addButton('Track event', trackEvent);
addButton('Show conversations', showConversations);

window.open();

function initializeSDK() {
	Freshchat.initialize({ appId: APP_ID, appKey: APP_KEY, domain: APP_DOMAIN });
}

function addButton(title, action) {
	const btn = Ti.UI.createButton({ title, top: 50 });
	btn.addEventListener('click', () => action());

	window.add(btn);
}

function signInUser() {
	Freshchat.signInUser({ firstName: 'John', lastName: 'Doe', email: 'john@doe.com' })
}

function signOutUser() {
	Freshchat.signOutUser();
}

function updateUser() {
	Freshchat.updateUserProperty('firstName', 'Hans');
}

function trackEvent() {
	Freshchat.trackEvent('test_event', { prop1: true, hello: 'tirocks' });	
}

function showConversations() {
	Freshchat.showConversations();
}
