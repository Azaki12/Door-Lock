abstract class AppStates {}

class AppInit extends AppStates {}

class AppStateChange extends AppStates {}

class AppCreateConnectionSuccess extends AppStates {}

class AppCreateConnectionError extends AppStates {}

class AppCreateConnectionLoading extends AppStates {}

class AppStateSendSuccess extends AppStates {}

class AppStateSendError extends AppStates {}

class AppStateConnectionInit extends AppStates {}

class AppStateServerInit extends AppStates {}

class AppGetServer extends AppStates {}

class AppGetMessage extends AppStates {}

class AppSetMessage extends AppStates {}
