package com.by.exception;

/**
 * Created by yagamai on 16-3-9.
 */
public class ScoreAlreadyAddedException extends RuntimeException{
    private static final long serialVersionUID = 1L;

    public ScoreAlreadyAddedException(){
        super("该小票已积过分");
    }
}
