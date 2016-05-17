class NotesController < ApplicationController
  before_action :require_login

  def new
    @note = Note.new
    @note.track_id = params[:track_id]
    render :new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      flash[:message] = "Note was posted succesfully!"
      redirect_to track_url(@note.track)
    else
      flash[:errors] = @note.errors.full_messages
      render :new
    end
  end

  def show
  end

  def destroy
    @note = Note.find(params[:id])
    track = @note.track
    if @note.author == current_user
      @note.delete
    else
      flash[:errors] = ["Cannot delete another user's note!"]
    end
    redirect_to track_url(track)
  end

  private
  def note_params
    params.require(:note).permit(:track_id, :body)
  end

end
