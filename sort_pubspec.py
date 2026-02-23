import yaml

def sort_pub_dependencies():
    with open('pubspec.yaml', 'r') as f:
        data = yaml.safe_load(f)
    
    if 'dependencies' in data:
        # Separate flutter from other dependencies to keep it at the top or follow standard
        deps = data['dependencies']
        flutter_sdk = deps.pop('flutter', None)
        
        sorted_deps = dict(sorted(deps.items()))
        
        # Put flutter back at the beginning of standard dependencies if it was there
        new_deps = {}
        if flutter_sdk:
            new_deps['flutter'] = flutter_sdk
        new_deps.update(sorted_deps)
        
        # Add missing dependencies if needed
        if 'http_parser' not in new_deps:
            new_deps['http_parser'] = '^1.1.0'
        if 'path' not in new_deps:
            new_deps['path'] = '^1.9.0'
            
        data['dependencies'] = new_deps
        
    if 'dev_dependencies' in data:
        data['dev_dependencies'] = dict(sorted(data['dev_dependencies'].items()))
        
    with open('pubspec.yaml', 'w') as f:
        yaml.dump(data, f, sort_keys=False)

if __name__ == "__main__":
    sort_pub_dependencies()
