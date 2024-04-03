#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>

#define MAX_SESSIONS 10 // Maximum number of sessions

// Define a session struct to hold window information
typedef struct {
  int num_windows;  // Number of windows in the session
  WINDOW* windows[5]; // Array of pointers to windows (limited to 5 for now)
  int current_window; // Index of the currently active window
} Session;

Session sessions[MAX_SESSIONS]; // Array of sessions
int current_session = -1; // Index of the currently active session (-1 for none)

WINDOW* main_win; // Main window for the multiplexer

// Function to initialize ncurses
void init_ncurses() {
  initscr();
  cbreak(); // Disable line buffering
  noecho();  // Don't echo characters on screen
  curs_set(0); // Hide cursor
  refresh();
}

// Function to create a new session
void create_session() {
  int i;
  // Find an empty slot in the sessions array
  for (i = 0; i < MAX_SESSIONS; i++) {
    if (sessions[i].num_windows == 0) {
      sessions[i].num_windows = 1;
      sessions[i].windows[0] = newwin(LINES - 1, COLS - 1, 1, 1); // Create a new window with starting coordinates
      sessions[i].current_window = 0;
      wrefresh(sessions[i].windows[0]);
      current_session = i;
      break;
    }
  }
  mvprintw(LINES - 1, 0, "Session created!");
  refresh();
}

// Function to switch between sessions (improved)
void switch_session(int key) {
  int session_index = key - '1'; // Assuming number keys starting from 1
  if (session_index >= 0 && session_index < MAX_SESSIONS && sessions[session_index].num_windows > 0) {
    current_session = session_index;
    mvprintw(LINES - 1, 0, "Switched to session %d", session_index + 1); // Display session number
    refresh();
    wrefresh(sessions[current_session].windows[sessions[current_session].current_window]);
  } else {
    mvprintw(LINES - 1, 0, "Invalid session! Only sessions 1 to %d exist.", MAX_SESSIONS);
    refresh();
  }
}

// Function to display a list of active sessions (optional)
void list_sessions() {
  int i, count = 0;
  mvprintw(LINES - 1, 0, "Active Sessions:");
  refresh();
  for (i = 0; i < MAX_SESSIONS; i++) {
    if (sessions[i].num_windows > 0) {
      count++;  // Count active sessions
      mvprintw(LINES - 1 - count, 0, "- Session %d", i + 1);
      refresh();
    }
  }
  // Display message if no sessions are active
  if (count == 0) {
    mvprintw(LINES - 1 - count, 0, "  No active sessions found.");
    refresh();
  }
}

// Function to switch session based on listed information (new)
void switch_listed_session() {
  int ch, session_index;
  list_sessions(); // Display list of active sessions
  mvprintw(LINES - 1, 0, "Enter session number to switch (or 'q' to cancel): ");
  refresh();
  ch = getch();
  if (ch >= '1' && ch <= '0' + MAX_SESSIONS) { // Check for valid number within range
    session_index = ch - '1';
    if (sessions[session_index].num_windows > 0) {
      switch_session(ch);  // Call existing switch_session function
    } else {
      mvprintw(LINES - 1, 0, "Invalid session! Session %d is not active.", session_index + 1);
      refresh();
    }
 } else if (ch == 'q' || ch == 'Q') {
    mvprintw(LINES - 1, 0, "Switching canceled.");
    refresh();
  } else {
    mvprintw(LINES - 1, 0, "Invalid input! Please enter a number (1-%d) or 'q' to cancel.", MAX_SESSIONS);
    refresh();
  }
}

int main() {
  init_ncurses();

  // Main loop for handling user input
  while (1) {
    int ch = getch();
    switch (ch) {
      case 'n': // Create new session
        create_session();
        break;
      case 's': // List and switch sessions
        switch_listed_session();
        break;
      case 'l': // List active sessions (optional)
        list_sessions();
        break;
      default:
        mvprintw(LINES - 1, 0, "Invalid command!");
        refresh();
        break;
    }
  }

  endwin(); // End ncurses
  return 0;
}
