package com.by.actor;

import akka.actor.UntypedActor;
import com.by.exception.*;
import com.by.message.GiftCouponMessage;
import com.by.model.GiftCoupon;
import com.by.model.Member;
import com.by.service.GiftCouponMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.Locale;

/**
 * Created by yagamai on 15-12-1.
 */
@Component("GiftCouponActor")
@Scope("prototype")
public class GiftCouponActor extends UntypedActor {
    @Autowired
    private GiftCouponMemberService service;
    @Autowired
    private MessageSource messageSource;

    @Override
    public void onReceive(Object message) throws Exception {
        if (message instanceof GiftCouponMessage) {
            GiftCouponMessage couponMessage = (GiftCouponMessage) message;
            GiftCoupon coupon = couponMessage.getCoupon();
            int total = couponMessage.getTotal();
            Member member = couponMessage.getMember();
            try {
                service.exchangeCoupon(coupon, member, total);
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
