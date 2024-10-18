

#define INTERFACE_BROWSER_ID 0xABCDE
#define INTERFACE_BROWSER_URL "https://ioannisdev.de/cef.html"

public OnCefInitialize(player_id, success) {
    if (success == 1) {
        // it is not hidden and not focused, we should be able to see it but cannot input from mouse / keyboard to it.
        cef_create_browser(player_id, INTERFACE_BROWSER_ID, INTERFACE_BROWSER_URL, false, false);
        return;
    }

    SendClientMessage(player_id, -1, "Ahh to bad you cannot see our new cool interface ...");
}