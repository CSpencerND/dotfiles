def get_event() -> str:
    from datetime import datetime

    icons: dict = {
        "Lunar Eclipse": " ",
        "Solar Eclipse": "  ",
        "Meteor Shower": " ",
        "Spring": " ",
        "Summer": "履 ",
        "Autumn": " ",
        "Winter": " ",
        "Savings Start": " ",
        "Savings End": " ",
    }

    # source = https://www.timeanddate.com/eclipse/in/@z-us-18328?iso=20221108
    events: dict = {
        "03/12/22": "Savings Start",
        "03/20/22": "Spring",
        "04/22/22": "Meteor Shower",
        "04/23/22": "Meteor Shower",
        "05/05/22": "Meteor Shower",
        "05/06/22": "Meteor Shower",
        "05/15/22": "Lunar Eclipse",
        "05/16/22": "Lunar Eclipse",
        "06/21/22": "Summer",
        "08/12/22": "Meteor Shower",
        "08/13/22": "Meteor Shower",
        "09/22/22": "Autumn",
        "10/08/22": "Meteor Shower",
        "10/09/22": "Meteor Shower",
        "10/21/22": "Meteor Shower",
        "10/22/22": "Meteor Shower",
        "11/05/22": "Savings End",
        "11/08/22": "Lunar Eclipse",
        "11/17/22": "Meteor Shower",
        "11/18/22": "Meteor Shower",
        "12/13/22": "Meteor Shower",
        "12/14/22": "Meteor Shower",
        "12/21/22": "Winter",
        "12/22/22": "Meteor Shower",
        "12/23/22": "Meteor Shower",
        "01/03/23": "Meteor Shower",
        "01/04/23": "Meteor Shower",
    }

    current: str = datetime.now().strftime("%x")
    icon: str = ""

    for date, event in events.items():
        if current == date:
            icon = icons[event]

    return icon
