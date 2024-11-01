import express, { Request, Response } from "express";

const app = express();

interface IUser {
    username: string;
}

type RequestWithoutParams = Request<Record<string, never>, IUser>;
app.get("/", (_request: RequestWithoutParams, response) => {
    const user = { username: "user" };
    response.status(200).send(user);
});

app.listen(3000);