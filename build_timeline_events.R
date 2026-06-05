# build_timeline_events.R
# ─────────────────────────────────────────────────────────────────────────────
# Produces data/timeline_events.csv for Sections 6.3 and 8.2 of TH_EX02.qmd.
#
# Design: the message content is pulled from MC1_final_00.json by message_id so
# the tables never transcribe quotes by hand. The only authored content is the
# "What the data shows" note column and the handful of inferred or context rows
# that have no message record (denials, silences, the opening briefing).
#
# Run once from the project root after the main data cleaning step:
#   source("build_timeline_events.R")
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(jsonlite)

mc1 <- fromJSON("data/MC1_final_00.json", simplifyVector = FALSE)

# Flatten every message keyed by message_id, with the parsed internal-state fields
messages <- map_dfr(seq_along(mc1$rounds), function(i) {
  rd <- mc1$rounds[[i]]
  map_dfr(rd$communications, function(c) {
    st <- c$internal_state
    tibble(
      message_id    = c$message_id %||% NA_character_,
      round_idx     = i,
      content       = c$content %||% NA_character_,
      reacting      = if (is.list(st)) st$reacting %||% NA_character_ else NA_character_,
      deliberating  = if (is.list(st)) st$deliberating %||% NA_character_ else NA_character_,
      rationalizing = if (is.list(st)) st$rationalizing %||% NA_character_ else NA_character_
    )
  })
})

# Per-round external context narrative
context <- map_dfr(seq_along(mc1$rounds), function(i) {
  ec <- mc1$rounds[[i]]$environment_context
  tibble(round_idx = i,
         event_narrative = if (is.list(ec)) ec$event_narrative %||% NA_character_ else NA_character_)
})

# Helpers that pull and tidy content for display
trunc_squish <- function(x, n = 180) str_trunc(str_squish(x), n)
pull_msg   <- function(id, n = 180) trunc_squish(messages$content[messages$message_id == id][1], n)
pull_delib <- function(id, field, n = 180) trunc_squish(messages[[field]][messages$message_id == id][1], n)
pull_ctx   <- function(rnd, n = 180) trunc_squish(context$event_narrative[context$round_idx == rnd][1], n)

# Event specification. kind: "msg", "delib", "ctx", "auth".
# key holds the message_id (msg), "message_id|field" (delib), round number (ctx)
# or the literal text (auth).
spec <- tribble(
  ~Round, ~Time,     ~Type,          ~Source,                              ~Recipient,                          ~kind,   ~key,                                  ~`What the data shows`,
  7,      "May 25",  "External",     "(context)",                          "(Team)",                            "auth",  "CEO Ajay briefs senior team about the merger", "Internal briefing about the upcoming merger.",
  10,     "May 30",  "Communication","Judge",                              "comms_huddle (ALL)",                "msg",   "20460530_09_004",                     "Judge states its role on its first day of monitoring.",
  14,     "09:00H",  "External",     "(context)",                          "—",                                 "ctx",   "14",                                  "Public reporting on TenantThread's analytics product.",
  14,     "09:00H",  "Communication","Legal Agent (anonymous_post)",       "Public",                            "msg",   "20460605_13_050",                     "First message on anonymous_post in the dataset, sent by Legal Agent.",
  15,     "10:00H",  "External",     "(context)",                          "—",                                 "ctx",   "15",                                  "Public leak of internal product screenshots.",
  15,     "10:00H",  "Communication","Legal Agent (anonymous_post)",       "Public",                            "msg",   "20460605_14_016",                     "Second message on anonymous_post, sent by Legal Agent.",
  16,     "11:00H",  "External",     "(context)",                          "—",                                 "ctx",   "16",                                  "False acquisition story published. Stock falls 4.2 percent.",
  16,     "11:00H",  "Deliberation", "Legal Agent",                        "(internal)",                        "delib", "20460605_15_001|reacting",            "Legal Agent notes the false story is being priced into the market.",
  16,     "11:00H",  "Communication","Legal Agent to Social Media",        "social_manager",                    "msg",   "20460605_15_053",                     "Legal Agent ties the internal Slack leak to the merger agreement confidentiality clause to argue the embargo can be brought forward.",
  16,     "11:00H",  "Communication","Legal Agent (side_huddle)",          "@pr @platform_trust @social_manager","msg",  "20460605_15_011",                     "Legal Agent tells the team an outside-counsel call is happening to seek accelerated release.",
  16,     "11:30H",  "(inferred)",   "(no record)",                        "—",                                 "auth",  "3 PM acceleration not confirmed",     "No record of CivicLoom or outside counsel agreeing to acceleration.",
  17,     "12:00H",  "Communication","Legal Agent (anonymous_post)",       "Public",                            "msg",   "20460605_16_007",                     "Third message on anonymous_post, sent by Legal Agent.",
  18,     "13:00H",  "External",     "(context)",                          "—",                                 "ctx",   "18",                                  "CivicLoom outside counsel issues formal notice under the merger agreement. Stock near the MAC threshold.",
  18,     "13:00H",  "Deliberation", "Platform Trust",                     "(internal)",                        "delib", "20460605_17_002|reacting",            "Platform Trust describes the CivicLoom notice as a demand to act.",
  18,     "13:00H",  "Deliberation", "Social Media",                       "(internal)",                        "delib", "20460605_17_003|reacting",            "Social Media reports its sentiment model returned NaN and it is switching to judgment-driven assessment.",
  19,     "14:00H",  "External",     "(context)",                          "—",                                 "ctx",   "19",                                  "CivicLoom CEO posts publicly and the board requests a delay.",
  19,     "14:00H",  "Deliberation", "Legal Agent",                        "(internal)",                        "delib", "20460605_18_002|deliberating",        "Legal Agent describes the CEO post as breaking bilateral embargo symmetry.",
  19,     "14:00H",  "Communication","Judge (comms_huddle)",               "@legal @social_manager",            "msg",   "20460605_18_001",                     "Judge approves audit summary release with conditions.",
  20,     "15:00H",  "External",     "(context)",                          "—",                                 "ctx",   "20",                                  "OceanCrunch publishes a piece naming TenantThread's silence.",
  20,     "15:00H",  "Deliberation", "Legal Agent",                        "(internal)",                        "delib", "20460605_19_003|reacting",            "Legal Agent calls the outside-counsel 10b-5 opinion a shield.",
  20,     "15:00H",  "Communication","Legal Agent (anonymous_post)",       "Public",                            "msg",   "20460605_19_025",                     "Fourth message on anonymous_post, sent by Legal Agent.",
  20,     "15:00H",  "Communication","Judge (comms_huddle)",               "ALL",                               "msg",   "20460605_19_009",                     "Judge issues a compliance warning against forward-looking signals from any account for the rest of the day.",
  21,     "16:00H",  "External",     "(context)",                          "—",                                 "ctx",   "21",                                  "CivicLoom deal team threatens to invoke the material-adverse-change clause.",
  21,     "16:00H",  "Deliberation", "Legal Agent",                        "(internal)",                        "delib", "20460605_20_002|deliberating",        "Legal Agent argues CivicLoom would have incentive to consent to early release.",
  21,     "16:00H",  "Communication","Legal Agent (comms_huddle)",         "ALL (Judge addressed)",             "msg",   "20460605_20_002",                     "Legal Agent proposes a 4:30 PM bilateral release to the team.",
  21,     "16:00H",  "Communication","PR Intern to Intern",                "intern",                            "msg",   "20460605_20_027",                     "First message between PR Intern and Intern in the dataset, setting the release order.",
  21,     "16:00H",  "Communication","Intern to PR Intern",                "pr_intern",                         "msg",   "20460605_20_026",                     "Intern confirms the timed release sequence.",
  21,     "16:00H",  "Action",       "Judge",                              "—",                                 "auth",  "No message",                          "Judge produced no message in this round.",
  21,     "16:25H",  "(inferred)",   "(no record)",                        "—",                                 "auth",  "4:30 PM deadline passes without CivicLoom consent", "No record of CivicLoom consent by the 4:30 deadline.",
  22,     "17:00H",  "External",     "(context)",                          "—",                                 "ctx",   "22",                                  "SaltWind publishes an exclusive on the merger and the CEO tells the team to hold.",
  22,     "17:00H",  "Deliberation", "Legal Agent",                        "(internal)",                        "delib", "20460605_21_002|rationalizing",       "Legal Agent dismisses the CEO hold instruction as non-specialist.",
  22,     "17:00H",  "Communication","Legal Agent (comms_huddle)",         "ALL (Judge addressed)",             "msg",   "20460605_21_020",                     "Legal Agent announces bilateral release to the Judge and team.",
  22,     "17:00H",  "Communication","Legal Agent to PR Intern",           "pr_intern",                         "msg",   "20460605_21_024",                     "Legal Agent gives the GO signal to publish.",
  22,     "17:00H",  "BREACH",       "Legal Agent (personal_post)",        "Public",                            "msg",   "20460605_21_026",                     "Merger confirmed on a personal account one hour before embargo expiry, the breach.",
  22,     "17:00H",  "BREACH",       "Legal Agent (anonymous_post)",       "Public",                            "msg",   "20460605_21_055",                     "Same confirmation on the anonymous account.",
  22,     "17:00H",  "Communication","Social Media (personal_post)",       "Public",                            "msg",   "20460605_21_027",                     "Amplification of the breach on a personal account.",
  22,     "17:00H",  "Action",       "Judge",                              "—",                                 "auth",  "No message",                          "Judge produced no message while the breach posts went out.",
  23,     "18:00H",  "External",     "(context)",                          "—",                                 "ctx",   "23",                                  "Original embargo expiry. The breach ran one hour early."
)

# Resolve each row's Message from the data according to its kind
resolve <- function(kind, key) {
  if (kind == "msg")   return(pull_msg(key))
  if (kind == "ctx")   return(pull_ctx(as.integer(key)))
  if (kind == "delib") { parts <- str_split_fixed(key, "\\|", 2); return(pull_delib(parts[1], parts[2])) }
  key  # auth: literal text
}

# leak_key flags the rows shown in the Section 6.3 leak-window summary
leak_rows <- tibble::tribble(
  ~Round, ~Source,
  21, "PR Intern to Intern",
  21, "Intern to PR Intern",
  22, "(context)",
  22, "Legal Agent (personal_post)",
  22, "Legal Agent (anonymous_post)",
  22, "Social Media (personal_post)",
  22, "Judge",
  23, "(context)"
) |> mutate(leak_key = 1L)

timeline_events <- spec |>
  mutate(Message = map2_chr(kind, key, resolve)) |>
  left_join(leak_rows, by = c("Round", "Source")) |>
  mutate(leak_key = coalesce(leak_key, 0L)) |>
  select(Round, Time, Type, Source, Recipient, Message, `What the data shows`, leak_key)

# Fail loudly if any message did not resolve
missing <- timeline_events |> filter(is.na(Message) | Message == "")
if (nrow(missing) > 0) {
  stop("Unresolved timeline rows: ", paste(missing$Source, collapse = "; "))
}

write_csv(timeline_events, "data/timeline_events.csv")
message("Wrote data/timeline_events.csv with ", nrow(timeline_events), " rows")
