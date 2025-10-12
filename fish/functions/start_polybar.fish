function start_polybar
  # Kill existing polybar processes
  pkill polybar 2>/dev/null || true
  
  # Wait a moment
  sleep 0.5
  
  # Start polybar
  polybar main &
  
  echo "Polybar started"
end








