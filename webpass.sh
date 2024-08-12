# Define the webpass function
webpass() {
    local website password password_hash password_base64 secure_password
    local PASSWORD_FILE="$HOME/.password_store"  # Store password file in the home directory

    # Function to initialize the password file if it doesn't exist
    initialize_password_file() {
        if [ ! -f "$PASSWORD_FILE" ]; then
            touch "$PASSWORD_FILE"
            chmod 600 "$PASSWORD_FILE"
        fi
    }

    # Function to generate a secure password based on website and password
    generate_secure_password() {
        local site=$1
        local pass=$2

        # Generate a SHA-256 hash of the site and password
        password_hash=$(echo -n "$site$pass" | sha256sum | cut -d" " -f1)        
        # Convert the SHA-256 hash to Base64
        password_base64=$(echo -n "$password_hash" | xxd -r -p | base64)        
        # Take the first 16 characters of the Base64 encoded string
        secure_password=$(echo -n "$password_base64" | head -c 16)
    }

    # Function to store a password in the hidden file
    store_password() {
        local site=$1
        local pass=$2

        # Check if a password already exists for the site
        if grep -q "^$site:" "$PASSWORD_FILE"; then
            echo "A password already exists for $site. Would you like to update it? (yes/no)"
            read -r response
            
            # Convert response to lowercase to handle different cases
            response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

            if [ "$response" != "yes" ]; then
                echo "Password update aborted."
                return
            fi

            # Remove the existing password entry for the site
            grep -v "^$site:" "$PASSWORD_FILE" > "$PASSWORD_FILE.tmp" && mv "$PASSWORD_FILE.tmp" "$PASSWORD_FILE"
        fi

        # Generate a secure password
        generate_secure_password "$site" "$pass"

        # Store the password in the hidden file
        echo "$site:$pass" >> "$PASSWORD_FILE"
        chmod 600 "$PASSWORD_FILE"

        echo "Password for $site stored successfully."
        echo "Use this password: $secure_password"
    }

    # Function to get a password for a given site from the password store
    get_pass() {
        local site=$1
        local stored_pass
        if grep -q "^$site:" "$PASSWORD_FILE"; then
            # Retrieve the stored password
            stored_pass=$(grep "^$site:" "$PASSWORD_FILE" | cut -d":" -f2)
            
            echo "This is site: $site and stored password: $stored_pass"
            
            generate_secure_password "$site" "$stored_pass"
            
            # Echo the secure password
            echo "Secure password for $site: $secure_password"
        else
            echo "No password found for $site."
        fi
    }

    # Check if -g flag is provided
    if [ "$1" == "-g" ]; then
        shift

        initialize_password_file
        get_pass "$1"
        return 0
    fi

    # Normal execution for storing a password
    website=$1
    if [ -z "$website" ]; then
        echo "Error: site cannot be empty."
        return 1
    fi

    # Hide the password input
    stty -echo
    read -p "Password: " password
    echo
    stty echo

    if [ -z "$password" ]; then
        echo "Error: Password cannot be empty."
        return 1
    fi

    initialize_password_file
    store_password "$website" "$password"
}
