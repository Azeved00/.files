echo "generating key"

#here i still need to do some work
# like get how many keys i want to generate
# the email
# the name
# possibly the type
# and

ssh-keygen -t ed25519 -C "jferazevedo@gmail.com"


eval $(ssh-agent -s) 
ssh-add ~/.ssh/id_ed25519

cat ~/.ssh/id_ed25519.pub
