from pathlib import Path
from jinja2 import Environment, FileSystemLoader

env = Environment(loader=FileSystemLoader(str(Path('.', 'templates'))))
template = env.get_template('hello_user.txt.j2')

data = {
    'users': ['Hanako', 'Bob', 'Fang', 'Soyun']
}

output_dir = Path('.', 'output')
output_dir.mkdir(exist_ok=True, parents=True)

file_name = str(Path(__file__).name) + '.txt'
with open(str(Path(output_dir, file_name)), mode='w') as f:
    f.write(template.render(data))

file_name = str(Path(__file__).name) + '.md'
with open(str(Path(output_dir, file_name)), mode='w') as f:
    f.write(template.render(data))