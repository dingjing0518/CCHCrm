package com.by.actor;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.by.exception.AlreadyExchangeException;
import com.by.exception.NotEnoughScoreException;
import com.by.exception.NotFoundException;
import com.by.exception.NotValidException;
import com.by.exception.OutOfStorageException;
import com.by.message.ShopCouponMessage;
import com.by.model.Member;
import com.by.model.ShopCoupon;
import com.by.service.ShopCouponMemberService;

import akka.actor.UntypedActor;
import scala.concurrent.duration.Duration;

/**
 * Created by yagamai on 15-12-8.
 */
@Component("ActivityCouponActor")
@Scope("prototype")
public class ActivityCouponActor extends UntypedActor {
    @Autowired
    private ShopCouponMemberService service;
    @Autowired
    private MessageSource messageSource;

    @Override
    public void onReceive(Object message) throws Exception {
        if (message instanceof ShopCouponMessage) {
            ShopCouponMessage couponMessage = (ShopCouponMessage) message;
            ShopCoupon coupon = couponMessage.getCoupon();
            Member member = couponMessage.getMember();
            try {
                service.exchangeCoupon(member, coupon);
                sender().tell("success", null);
            } catch (AlreadyExchangeException e) {
                sender().tell(getMessage("coupon.AlreadyExchangeException"), null);
            } catch (OutOfStorageException e) {
                sender().tell(getMessage("coupon.OutOfStorageException"), null);
            } catch (NotValidException e) {
                sender().tell(getMessage("coupon.NotValidException"), null);
            } catch (NotEnoughScoreException e) {
                sender().tell(getMessage("coupon.NotEnoughScoreException"), null);
            } catch (NotFoundException e) {
                sender().tell(getMessage("coupon.NotFoundException"), null);
            }
        } else {
            unhandled(message);
        }
    }

    private String getMessage(String code) {
        return messageSource.getMessage(code, new Object[]{}, Locale.CHINA);
    }
}
