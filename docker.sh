MOCK_FLAG_FILE="is-mock-docker.txt"

if [ ! -f "$MOCK_FLAG_FILE" ]; then
    docker $1 $2 $3 $4 $5 $6 $7
else
    echo "[mock] docker $1 $2 $3 $4 $5 $6 $7"
fi