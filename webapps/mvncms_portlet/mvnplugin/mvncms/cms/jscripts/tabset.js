var TabSet = Class.create();
TabSet.prototype = {

    lastActivatedPanelId: null,

    initialize: function(tabSetId, panelArray, activeId, actionLink)
    {
        this.tabSetId = tabSetId;
        this.activeId = activeId;
        this.panelArray = panelArray.split(",");
        this.actionLink = actionLink;

        this.panelArray.each(function(element)
        {
            $('panel_' + element).onclick = this.activate.bindAsEventListener(this);
            if (this.activeId != element)
                $(element).hide();
            else
            {
                $(element).show();
                this.lastActivatedPanelId = 'panel_' + element;
            }

        }.bind(this));
    },
    activate: function(evt)
    {
        var clickedPanel = Event.element(evt).id;
        var clickedPanelContent = clickedPanel.split("_")[1];

        this.deactivate(this.lastActivatedPanelId);

        $(clickedPanelContent).show();
        $(clickedPanel).addClassName("activated");
        this.lastActivatedPanelId = clickedPanel;

        new Ajax.Request(this.actionLink, {
            method: 'post',
			parameters: {'activePanel': clickedPanelContent},
			onFailure: function(t)
            {
                //alert('Error communication with the server: ' + t.responseText.stripTags());
            },
            onException: function(t, exception)
            {
                //alert('Error communication with the server: ' + exception.stripTags());
            }
        });
    },
    deactivate: function(panelId)
    {
		if (panelId == null)
			return;
		
		var panelContent = panelId.split("_")[1];
        $(panelContent).hide();
        $(panelId).removeClassName("activated");
    }
}