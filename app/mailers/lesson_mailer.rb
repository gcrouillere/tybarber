class LessonMailer < ApplicationMailer

  def mail_user_after_lesson_destroy(lesson)
    @lesson = lesson
    @closest_start = Findcloseststart.new(@lesson).closest_start(@lesson)
    if @lesson.confirmed
      mail(to: @lesson.user.email, subject: 'Annulation de votre stage de poterie chez Françoise Nugier')
    else
      mail(to: @lesson.user.email, subject: 'Refus de votre demande de stage de poterie chez Françoise Nugier')
    end
  end

  def mail_user_after_confirmation(lesson)
    @lesson = lesson
    mail(to: @lesson.user.email, subject: 'Confirmation de votre stage de poterie chez Françoise Nugier')
  end

  def mail_francoise_after_lesson_create(lesson)
    @lesson = lesson
    mail(to: 'nugierfrancoise@yahoo.fr', subject: 'Nouvelle demande de stage reçue')
  end

  def mail_user_after_lesson_payment(lesson, user)
    @lesson = lesson
    @user = user
    mail(to: @lesson.user.email, subject: 'Paiement des arrhes pour votre stage de poterie chez Françoise Nugier')
  end

  def mail_francoise_after_lesson_payment(lesson, user)
    @lesson = lesson
    mail(to: 'nugierfrancoise@yahoo.fr', subject: 'Paiement des arrhes pour stage recu')
  end

end
