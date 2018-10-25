import glob, random
from helpers import *
import helpers

main_dir = os.path.dirname(__file__) + '/main'

targets = sorted(glob.glob(main_dir + "/*.py"))
targets = [x.replace(main_dir + '/', '').replace('.py', '') for x in targets]
targets = list(filter(lambda x: x != "__init__", targets))
target_files = [main_dir + "/" + x + ".py" for x in targets]

def usage():
    print("Please select one target in")
    print("     all_tests")
    print("     " + ",".join(targets))
    sys.exit(1)


def test(file):
    os.system("python " + file)

if len(sys.argv) <= 1:
    usage()

target = sys.argv[1]


if target == "all_tests":
    print("Target " + str(target) + " selected")
    for x in targets:
        helpers.title(x)
        test(target_files[targets.index(x)])
elif target in targets:
    print("Target " + str(target) + " selected")
    helpers.title(target)
    test(target_files[targets.index(target)])
else:
    print("Invalid target: ", target)
    usage()
