class LinksController < ApplicationController

	def show
		@link = Link.find(params[:id])
		puts @link.inspect
		return render :plain => "Maximum download count exceeded for this file" if @link.download_count >= ENV['file_max_downloads'].to_i
		@link.increment!(:download_count)
		return redirect_to @link.url
	end

end
