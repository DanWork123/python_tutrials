from jinja2 import Environment, FileSystemLoader

env = Environment(loader=FileSystemLoader('./templates'))
template = env.get_template('hello_user.txt.j2')

data = {
    'users': ['Hanako', 'Bob', 'Fang', 'Soyun']
}

rendered = template.render(data)

print(rendered)