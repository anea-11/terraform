provider "aws"{
    region = "eu-west-3"
    # export AWS_ACCESS_KEY_ID=value            good practice, pass secret info as env vars; find expected env vars in provider's docs
    # export AWS_SECRET_ACCESS_KEY=value        good practice, pass secret info as env vars; find expected env vars in provider's docs


    /* Using env vars if ofc tied to the current session. If you want to globally configure credentials for aws specifically,
       you can use "aws configure" and you must have aws cli installed
    */
}
