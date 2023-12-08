exports.handler = async (event) => {
    const message = "Hello, World!";
    
    console.log(event)

    const response = {
        isBase64Encoded: false,
        statusCode: 200,
        statusDescription: "200 OK",
        headers: {
            "Content-Type": "application/json"
        },
        body: "Hello World"
    };

    return response;
};