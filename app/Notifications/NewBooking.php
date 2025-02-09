<?php
/*
 * File name: NewBooking.php
 * Last modified: 2024.04.18 at 17:41:01
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2024
 */

namespace App\Notifications;

use App\Models\Booking;
// use Benwilkins\FCM\FcmMessage;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use Illuminate\Support\Facades\Config;

class NewBooking extends Notification
{
    use Queueable;

    /**
     * @var Booking
     */
    private Booking $booking;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct(Booking $booking)
    {
        //
        $this->booking = $booking;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param mixed $notifiable
     * @return array
     */
    public function via(mixed $notifiable): array
    {
        
        $value = Config::get('gnittes.enable_email_notifications');
        $types = ['database'];
        if ($value) {
            $types[] = 'mail';
        }
        return $types;
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param mixed $notifiable
     * @return MailMessage
     */
    public function toMail(mixed $notifiable): MailMessage
    {
        return (new MailMessage)
            ->markdown("notifications::booking", ['booking' => $this->booking])
            ->subject(trans('lang.notification_new_booking', ['booking_id' => $this->booking->id, 'user_name' => $this->booking->user->name]) . " | " . setting('app_name', ''))
            ->greeting(trans('lang.notification_new_booking', ['booking_id' => $this->booking->id, 'user_name' => $this->booking->user->name]))
            ->action(trans('lang.booking_details'), route('bookings.show', $this->booking->id));
    }

   

    private function getSalonMediaUrl(): string
    {
        if ($this->booking->salon->hasMedia('image')) {
            return $this->booking->salon->getFirstMediaUrl('image', 'thumb');
        } else {
            return asset('images/image_default.png');
        }
    }

    /**
     * Get the array representation of the notification.
     *
     * @param mixed $notifiable
     * @return array
     */
    public function toArray(mixed $notifiable): array
    {
        return [
            'booking_id' => $this->booking['id'],
        ];
    }
}