from pprint import pprint


class Bootcamp:
    def __init__(self, name, duration, schedule, cost, langs):
        self.name = name
        self.duration = duration
        self.schedule = schedule
        self.cost = cost
        self.langs = langs

    def __repr__(self):
        return f"""
{self.name}
Duration: {self.duration}
Schedule: {self.schedule}
Cost: {self.cost}
Languages: {self.langs}
"""


app_acad = Bootcamp(
    'App Academy', '24 weeks', '8 - 5', 'ISA 30k',
    'SWE: web stack/flux/express, python stack, sql',
)


flatiron = Bootcamp(
    '*Flatiron School', '15 weeks/5 months', '9 - 6', '$500 dep and 17k+int',
    '''SWE: web stack, ruby stack, http, git, orm/sql
    DataSci/ML: python, sql, regression, statistics, a/b testing, big data, deep learning, nlp'''
)


gnl_assy = Bootcamp(
    'General Assembly', '13 weeks', '9 - 5', 'ISA/15k/loan',
    'SWE: web stack/angular/ajax/express, ruby stack, python stack, mongodb/sql, git',
)


coding_dojo = Bootcamp(
    'Coding Dojo', '14/32 weeks', '40 hrs', '16k',
    'SWE: web stack/jquery, python stack, c#/.net, java, sql, mongo, wire framing, socket io',
)


hack_react = Bootcamp(
    '*Hack Reactor/Galvanize', '14 weeks/25 weeks', '9-8 or weekends', '2k dep. 18k ISA',
    """SWE: web stack/mvc/ajax, deployment(digital ocean, heroku), npm/node/express, sql/mongo/orm 
    DataSci/ML: python libraries, oop, command line, bayesian models, regression, nlp, big data, web stack/flask"""
)


lambda_ = Bootcamp(
    'Lambda School', '6 months', '8-5', '30k ISA',
    '''SWE: web stack, node, python, redux, sql
    DataSci/Ml: python, sql, data vis, linear algebra, stats and modeling, nlp'''
)


rithm = Bootcamp(
    'Rithm School', '16 weeks', '9 - 6', '23k ISA',
    '''SWE: web stack/bootstrap, python/flask, sql, terminal, git, node/express, compsci 
    '''
)


fs_acad = Bootcamp(

)


sci2datasci = Bootcamp(

)